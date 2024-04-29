const mongoose = require('mongoose');
const User = require('./user');

const noteSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Make sure the User model is defined and imported correctly
    required: true
  },
  title: {
    type: String,
    required: true // Uncomment if title is required
  },
  description: {
    type: String,
    required: true // Uncomment if content is required
  }
});

const Note = mongoose.model('Note', noteSchema);

module.exports = Note;
