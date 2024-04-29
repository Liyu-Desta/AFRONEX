const Note = require('../models/note');
const Joi = require('joi');

// Controller function to create a new note
exports.createNote = async (req, res) => {
  try {
    // Define the validation schema
    const schema = Joi.object({
      title: Joi.string().required(),
      description: Joi.string().required(),
      userId: Joi.string().required()
    });

    // Validate the request body against the schema
    const { error, value } = schema.validate(req.body);

    // If validation fails, return a 400 error with the validation details
    if (error) {
      return res.status(400).json({ success: false, error: error.details });
    }

    // Extract data from the validated request body
    const { title, description, userId } = value;

    // Create a new note object
    const newNote = new Note({
      title,
      description,
      userId
    });

    // Save the new note to the database
    await newNote.save();

    // Send a success response
    res.status(201).json({ success: true, message: 'Note created successfully', note: newNote });
  } catch (error) {
    // Handle errors
    console.error('Error creating note:', error);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
};

// Controller function to retrieve all notes
exports.getAllNotes = async (req, res) => {
  try {
    // Retrieve all notes from the database
    const notes = await Note.find();

    // Send the list of notes as the response
    res.status(200).json({ success: true, notes });
  } catch (error) {
    // Handle errors
    console.error('Error retrieving notes:', error);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
};

// Controller function to retrieve a single note by ID
exports.getNoteById = async (req, res) => {
  try {
    // Extract the note ID from the request parameters
    const { id } = req.params;

    // Find the note by ID in the database
    const note = await Note.findById(id);

    // If the note is not found, return a 404 error
    if (!note) {
      return res.status(404).json({ success: false, error: 'Note not found' });
    }

    // Send the note as the response
    res.status(200).json({ success: true, note });
  } catch (error) {
    // Handle errors
    console.error('Error retrieving note by ID:', error);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
};

// Controller function to update a note by ID
exports.updateNoteById = async (req, res) => {
  try {
    // Extract the note ID and updated data from the request body
    const { id } = req.params;
    const { title, description,userId } = req.body;

    // Find the note by ID in the database and update it
    const updatedNote = await Note.findByIdAndUpdate(id, { title, description }, { new: true });

    // If the note is not found, return a 404 error
    if (!updatedNote) {
      return res.status(404).json({ success: false, error: 'Note not found' });
    }

    // Send the updated note as the response
    res.status(200).json({ success: true, message: 'Note updated successfully', note: updatedNote });
  } catch (error) {
    // Handle errors
    console.error('Error updating note by ID:', error);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
};

// Controller function to delete a note by ID
exports.deleteNoteById = async (req, res) => {
  try {
    // Extract the note ID from the request parameters
    const { id } = req.params;

    // Find the note by ID in the database and delete it
    const deletedNote = await Note.findByIdAndDelete(id);

    // If the note is not found, return a 404 error
    if (!deletedNote) {
      return res.status(404).json({ success: false, error: 'Note not found' });
    }

    // Send a success response
    res.status(200).json({ success: true, message: 'Note deleted successfully' });
  } catch (error) {
    // Handle errors
    console.error('Error deleting note by ID:', error);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
};
