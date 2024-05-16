
const sql = require('mssql');
const config = require('./dbConfig');

// Function to get all cars
async function getAllFeedback() {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM [dbo].[Feedback]');
    return result.recordset;
  } catch (err) {
    console.error(err);
    throw err; // Re-throw the error to handle it outside
  }
}

module.exports = { getAllFeedback };