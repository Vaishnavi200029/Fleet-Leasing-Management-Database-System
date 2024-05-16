const sql = require('mssql');
const config = require('./dbConfig');

async function makeReservation(reservationData) {
    const { scheduleId, customerId, insuranceId, pickupDate, returnDate, cost } = reservationData;
    try {
        const pool = await sql.connect(config);
        const result = await pool.request()
            .input('Schedule_ID', sql.Int, scheduleId)
            .input('Customer_ID', sql.Int, customerId)
            .input('Insurance_ID', sql.Int, insuranceId)
            .input('Pickup_Date', sql.DateTime, pickupDate)
            .input('Return_Date', sql.DateTime, returnDate)
            .input('Cost', sql.Decimal(10, 2), cost)
            .query('INSERT INTO [dbo].[Reservation] (Schedule_ID, Customer_ID, Insurance_ID, Pickup_Date, Return_Date, Cost) VALUES (@Schedule_ID, @Customer_ID, @Insurance_ID, @Pickup_Date, @Return_Date, @Cost); SELECT SCOPE_IDENTITY() AS ReservationId;');
            
        return result.recordset[0].ReservationId;
    } catch (error) {
        console.error('Error making reservation:', error);
        throw error;
    }
}

async function getReservationCount() {
    try {
      const pool = await sql.connect(config);
      const result = await pool.request().query('SELECT COUNT(*) AS ReservationCount FROM [dbo].[Reservation]');
      return result.recordset[0].ReservationCount;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }

  async function getfeedbackCount() {
    try {
      const pool = await sql.connect(config);
      const result = await pool.request().query('SELECT COUNT(*) AS FeedbackCount FROM [dbo].[Feedback]');
      return result.recordset[0].FeedbackCount;
    } catch (err) {
      console.error(err);
      throw err;
    }
  }


module.exports = {
    makeReservation,
    getReservationCount,
    getfeedbackCount,
};


