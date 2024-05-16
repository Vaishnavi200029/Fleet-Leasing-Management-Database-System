// db.js

const mysql = require('mysql');

// Create a connection pool
const pool = mysql.createConnection({
    user: 'Admin',
    password: 'Mysql@1',
    host: 'localhost',
    database: 'FleetRental',
    options: {
      trustServerCertificate: true,
      enableArithAbout: true,
      trustedConnection: false,
    },
  connectionLimit: 10, // Adjust as needed
});

// Promisify the pool.query() method to use async/await
const query = (sql, params) => {
  return new Promise((resolve, reject) => {
    pool.query(sql, params, (error, results) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(results);
    });
  });
};

module.exports = { query };
