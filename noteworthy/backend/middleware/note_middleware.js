const { authenticateJWT } = require('./auth_middleware');



// Authorization middleware to check if the user is authorized to access the note
const authorizeNoteAccess = (req, res, next) => {
  const userIdFromToken = req.user ? req.user.id : null; // Check if req.user exists and access the id property
  const noteOwnerId = req.note ? req.note.userId : null; // Check if req.note exists and access the userId property

  // Check if the user is the owner of the note
  if (userIdFromToken !== noteOwnerId) {
    return res.status(403).json({ message: 'Unauthorized' });
  }

  // User is authorized, proceed to the next middleware or route handler
  next();
};
const validateNoteData = (req, res, next) => {
  const { title, description } = req.body;

  // Check if title and description are provided
  if (!title || !description) {
    return res.status(400).json({ message: 'Title and description are required' });
  }

  // Data is valid, proceed to the next middleware or route handler
  next();
};
module.exports = {
  validateNoteData,
  authorizeNoteAccess,
};