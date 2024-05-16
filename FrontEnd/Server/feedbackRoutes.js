
const express = require('express');
const router = express.Router();
const feedbackController = require('./feedbackController');

router.get('/feedback', async (req, res) => {
    try {
      const feedback = await feedbackController.getAllFeedback();
      res.status(200).json(feedback);
    } catch (error) {
      console.error('Error fetching Feedback:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  

module.exports = router;