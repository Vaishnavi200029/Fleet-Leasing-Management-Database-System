// userRoutes.js

const express = require('express');
const router = express.Router();
const userController = require('./userController');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');


// Route to get all users
router.get('/users', async (req, res) => {
  try {
    const users = await userController.getAllUsers();
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/totalusers', async (req, res) => {
  try {
    const userCount = await userController.getUserCount();
    res.status(200).json(userCount);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to add a new user
router.post('/users', async (req, res) => {
  const userData = req.body;
  try {
    const userId = await userController.addUser(userData);
    res.status(201).json({ userId, message: 'User added successfully.' });
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to delete a user by User_ID
router.delete('/users/:userId', async (req, res) => {
  const userId = req.params.userId;
  try {
    const rowsAffected = await userController.deleteUser(userId);
    if (rowsAffected > 0) {
      res.status(200).json({ message: 'User deleted successfully.' });
    } else {
      res.status(404).json({ error: 'User not found.' });
    }
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await userController.authenticateUser(email, password);
    if (user) {
      // Authentication successful
      console.log('User authenticated successfully:', user);
      
      // Generate token
      const token = jwt.sign({
        userId: user.User_ID,
        email: user.Email,
        userRole: user.User_Role
      }, 'your_secret_key_here');
      
      // Return the token to the frontend
      res.status(200).json({ token , user});
    } else {
      // Authentication failed
      console.log('Authentication failed for user:', email);
      res.status(401).json({ error: 'Invalid credentials' });
    }
  } catch (error) {
    console.error('Error authenticating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


module.exports = router;

// {
//   "name": "Atharva Keshre",
//   "password": "password123",
//   "userRole": "Customer",
//   "email": "atharva.keshre@example.com",
//   "contactNumber": "6177357893"
// }
