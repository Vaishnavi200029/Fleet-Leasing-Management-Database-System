// server.js

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());



// Import route files
const userRoutes = require('./userRoutes');
const carRoutes = require('./carRoutes');
const reservationRoutes = require('./reservationRoutes');
const feedbackRoutes = require('./feedbackRoutes');

// Use route files as middleware
app.use('/api', userRoutes);
app.use('/api', carRoutes);
app.use('/api', reservationRoutes);
app.use('/api', feedbackRoutes);

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
