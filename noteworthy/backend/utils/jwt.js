const jwt = require('jsonwebtoken');
const { jwtSecretKey } = require('../config');

// Function to generate a JWT token
const generateToken = (payload) => {
  return jwt.sign(payload, jwtSecretKey, { expiresIn: '1h' }); // Set token expiration time as desired
};

// Function to verify and decode a JWT token
const verifyToken = (token) => {
  try {
    const decoded = jwt.verify(token, jwtSecretKey);
    return decoded;
  } catch (error) {
    // Token verification failed
    return null;
  }
};

module.exports = {
  generateToken,
  verifyToken,
};
