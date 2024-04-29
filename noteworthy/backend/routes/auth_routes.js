const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth_controller');

// Route for user registration
router.post('/register', authController.register);

// Route for user login
router.post('/login', authController.login);

router.get('/protected-route', authMiddleware.authenticateJWT, (req, res) => {
    // Route handler logic here
  });

module.exports = router;
