const jwt = require('jsonwebtoken');
const config = require('../config');

// Middleware function to authenticate JWT tokens
const authenticateJWT = (req, res, next) => {
  const token = req.headers.authorization;

  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  console.log('Token:', token);

  jwt.verify(token, config.secretKey, (err, decoded) => {
    if (err) {
      console.log('Error:', err);
      return res.status(403).json({ message: 'Forbidden' });
    }

    console.log('Decoded User:', decoded);
    req.user = decoded;
    next();
  });
};

module.exports = {
  authenticateJWT,
};