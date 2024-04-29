const express = require('express');
const router = express.Router();
const noteController = require('../controllers/note_controller');

// Route to create a new note
router.post('/notes', noteController.createNote);

// Route to retrieve all notes
router.get('/notes', noteController.getAllNotes);

// Route to retrieve a single note by ID
router.get('/notes/:id', noteController.getNoteById);

// Route to update a note by ID
router.put('/notes/:id', noteController.updateNoteById);

// Route to delete a note by ID
router.delete('/notes/:id', noteController.deleteNoteById);

router.get('/protected-route', authMiddleware.authenticateJWT, (req, res) => {
    // Route handler logic here
  });
module.exports = router;