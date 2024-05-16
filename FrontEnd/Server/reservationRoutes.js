const express = require('express');
const router = express.Router();
const reservationController = require('./reservationController');

router.post('/reservation', async (req, res) => {
    const { scheduleId, customerId, insuranceId, pickupDate, returnDate, cost } = req.body;
    try {
        const reservationId = await reservationController.makeReservation({ scheduleId, customerId, insuranceId, pickupDate, returnDate, cost });
        res.status(201).json({ reservationId, message: 'Reservation made successfully.' });
    } catch (error) {
        console.error('Error making reservation:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

router.get('/totalreservations', async (req, res) => {
    try {
      const reservationCount = await reservationController.getReservationCount();
      res.status(200).json(reservationCount);
    } catch (error) {
      console.error('Error fetching Reservation:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

  router.get('/totalfeedback', async (req, res) => {
    try {
      const feedbackCount = await reservationController.getfeedbackCount();
      res.status(200).json(feedbackCount);
    } catch (error) {
      console.error('Error fetching feedback:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });


module.exports = router;
