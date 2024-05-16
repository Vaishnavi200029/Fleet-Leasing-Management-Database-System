// carController.js

const sql = require('mssql');
const config = require('./dbConfig');

// Function to get all cars
async function getAllCars() {
  try {
    const pool = await sql.connect(config);
    const result = await pool.request().query('SELECT * FROM [dbo].[Car]');
    return result.recordset;
  } catch (err) {
    console.error(err);
    throw err; // Re-throw the error to handle it outside
  }
}

// Function to add a new car
async function addCar(car) {
    const { vin, model, make, year, color, mileage, rateHour } = car;
    try {
      const pool = await sql.connect(config);
      const result = await pool.request()
        .input('VIN', sql.NVarChar(17), vin)
        .input('Model_Name', sql.NVarChar(100), model)
        .input('Make', sql.NVarChar(50), make)
        .input('Year', sql.Int, year)
        .input('Color', sql.NVarChar(50), color)
        .input('Mileage', sql.Int, mileage)
        .input('RateHour', sql.Decimal(10, 2), rateHour)
        .query('INSERT INTO [dbo].[Car] (VIN, Model_Name, Make, Year, Color, Mileage, RateHour) VALUES (@VIN, @Model_Name, @Make, @Year, @Color, @Mileage, @RateHour); SELECT SCOPE_IDENTITY() AS CarId;');
        
      return result.recordset[0].CarId;
    } catch (error) {
      console.error('Error adding car:', error);
      throw error;
    }
  }

  async function getCarsCount() {
    try {
      const pool = await sql.connect(config);
      const result = await pool.request().query('SELECT COUNT(*) AS Carscount FROM [dbo].[Car]');
      return result.recordset[0].Carscount;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }
  
  // Function to get available cars between given dates
  async function getAvailableCars(startDate, endDate) {
    try {
      console.log('Start Date:', startDate);
      console.log('End Date:', endDate);
  
      const pool = await sql.connect(config);
      const query = `
        DECLARE @StartDateTime DATETIME = '${new Date(startDate).toISOString()}';
        DECLARE @EndDateTime DATETIME = '${new Date(endDate).toISOString()}';
        EXEC [FleetRental].[dbo].[GetAvailableCars] @StartDateTime, @EndDateTime;
      `;
      const result = await pool.request().query(query);
      return result.recordset;
    } catch (error) {
      console.error('Error fetching available cars:', error);
      throw error;
    }
  }
  

module.exports = { getAllCars, addCar, getCarsCount, getAvailableCars };


