// userController.js

const sql = require('mssql');
const config = require('./dbConfig');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Function to get all users
async function getAllUsers() {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM [dbo].[User]');
    return result.recordset;
  } catch (err) {
    console.error(err);
    throw err; // Re-throw the error to handle it outside
  }
}

// Function to get the count of users
async function getUserCount() {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT COUNT(*) AS UserCount FROM [dbo].[User]');
    return result.recordset[0].UserCount;
  } catch (err) {
    console.error(err);
    throw err;
  }
}

// Function to add a new user
async function addUser(user) {
  const { name, password, email, contactNumber } = user;
  const userRole = 'Customer';
  try {
    const pool = await sql.connect(config);
    const passwordBuffer = Buffer.from(password, 'utf-8'); // Convert password string to buffer
    const result = await pool.request()
      .input('Name', sql.NVarChar(100), name)
      .input('Password', sql.VarBinary(100), passwordBuffer) // Use passwordBuffer instead of password
      .input('User_Role', sql.NVarChar(50), userRole)
      .input('Email', sql.NVarChar(100), email)
      .input('Contact_Number', sql.NVarChar(15), contactNumber)
      .query('INSERT INTO [dbo].[User] (Name, Password, User_Role, Email, Contact_Number) VALUES (@Name, @Password, @User_Role, @Email, @Contact_Number); SELECT SCOPE_IDENTITY() AS UserId;');
      
    return result.recordset[0].UserId;
  } catch (error) {
    console.error('Error adding user:', error);
    throw error;
  }
}

// Function to delete a user by User_ID
async function deleteUser(userId) {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request()
      .input('UserId', sql.Int, userId)
      .query('DELETE FROM [dbo].[User] WHERE User_ID = @UserId');
      
    return result.rowsAffected[0]; // Return the number of rows affected
  } catch (error) {
    console.error('Error deleting user:', error);
    throw error;
  }
}

async function authenticateUser(email, password) {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request()
      .input('Email', sql.NVarChar(100), email)
      .query('SELECT * FROM [dbo].[User] WHERE Email = @Email');

    const user = result.recordset[0];
    if (!user) {
      return null; // User not found
    }

    const storedHashBuffer = Buffer.from(user.Password, 'hex'); // Convert varbinary to buffer
    const providedPasswordBuffer = Buffer.from(password, 'utf-8'); // Convert string to buffer
    const isPasswordValid = storedHashBuffer.equals(providedPasswordBuffer); // Compare buffers

    if (!isPasswordValid) {
      return null; // Password incorrect
    }

    // Generate and return token
    const token = jwt.sign({
      userId: user.User_ID,
      email: user.Email,
      userRole: user.User_Role
    }, 'your_secret_key_here');

    return {token, user};
  } catch (error) {
    console.error('Error authenticating user:', error);
    throw error;
  }
}





module.exports = { getAllUsers, addUser, deleteUser, authenticateUser, getUserCount};
