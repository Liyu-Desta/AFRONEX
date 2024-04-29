const crypto = require('crypto');

// Function to generate JWT secret key
const generateSecretKey = () => {
  // Generate 32 random bytes
  const randomBytes = crypto.randomBytes(32);

  // Convert bytes to hexadecimal string
  const secretKey = randomBytes.toString('hex');

  return secretKey;
};

// Generate JWT secret key
const jwtSecretKey = generateSecretKey();

module.exports = {
  mongoURI: 'mongodb://localhost:27017/noteworthy', // MongoDB connection URI
  secretKey: jwtSecretKey, // Secret key for JWT authentication
  port: process.env.PORT || 3000, // Port for the server to listen on
};
