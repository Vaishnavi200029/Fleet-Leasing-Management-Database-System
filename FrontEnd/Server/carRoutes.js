// carRoutes.js

const express = require('express');
const router = express.Router();
const carController = require('./carController');

// Route to get all cars
router.get('/cars', async (req, res) => {
  try {
    const cars = await carController.getAllCars();
    res.status(200).json(cars);
  } catch (error) {
    console.error('Error fetching cars:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to add a new car
router.post('/cars', async (req, res) => {
  const carData = req.body;
  try {
    const carId = await carController.addCar(carData);
    res.status(201).json({ carId, message: 'Car added successfully.' });
  } catch (error) {
    console.error('Error adding car:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/totalcars', async (req, res) => {
  try {
    const carscount = await carController.getCarsCount();
    res.status(200).json(carscount);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to check availability of cars

router.post('/availablecars', async (req, res) => {
  const { startDate, endDate } = req.body;

  try {
    if (!startDate || !endDate) {
      return res.status(400).json({ error: 'Both startDate and endDate are required' });
    }

    const availableCars = await carController.getAvailableCars(startDate, endDate);
    res.status(200).json(availableCars);
  } catch (error) {
    console.error('Error fetching available cars:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;


// {
//     "vin": "123",
//     "model": "Nano",
//     "make": "Tata",
//     "year": 2024,
//     "color": "Black",
//     "mileage": 5000,
//     "rateHour": 25.99
//   }