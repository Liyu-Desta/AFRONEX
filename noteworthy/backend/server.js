// Import required modules
const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');
const bodyParser = require('body-parser');
const cors = require('cors');
const Note = require('./models/note');
const User = require('./models/user');
const { authorizeNoteAccess, validateNoteData } = require('./middleware/note_middleware');

// Initialize Express app
const app = express();
const port = process.env.PORT || 3000;

// Middleware setup
app.use(cors());
app.use(bodyParser.json());

// MongoDB Connection URI
const uri = 'mongodb://localhost:27017/noteworthy';
const dbName = 'noteworthy';

// Create MongoDB client
const client = new MongoClient(uri, { useUnifiedTopology: true });

// Main function to start the server
async function main() {
  try {
    // Connect to MongoDB
    await client.connect();
    console.log('Connected to MongoDB');

    // Access the database
    const database = client.db(dbName);

    // Define API routes

    // User login route
    app.post('/api/users/login', async (req, res) => {
      const { username, password } = req.body;
      // Check username and password against database
      const user = await database.collection('users').findOne({ username, password });
      if (user) {
        res.status(200).json({ message: 'Login successful', userId: user._id });
      } else {
        res.status(401).json({ error: 'Invalid username or password' });
      }
    });

    app.post('/api/notes', authorizeNoteAccess, validateNoteData, async (req, res) => {
      try {
        const { title, description, userId } = req.body; // Destructure the required parameters from the request body
        const newNote = {
          userId,
          title,
          description,
        };
        
        // Insert the new note into the database
        const result = await database.collection('notes').insertOne(newNote);
        
        // Check if result.insertedId is defined
        if (result.insertedId && userId !== null) {
          // Send the inserted note as the response
          res.status(201).json({ message: 'Note created successfully', noteId: result.insertedId });
        } else {
          // Send an error response if result.insertedId is undefined or userId is null
          res.status(500).json({ error: 'Failed to insert note' });
        }
      } catch (error) {
        // If an error occurs, send an error response
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
      }
    });
    // Update a note route
    app.put('/api/notes/:id', async (req, res) => {
      const noteId = req.params.id;
      const updatedNote = req.body;
      // Update note
      const result = await database.collection('notes').findOneAndUpdate(
        { _id: new ObjectId(noteId) },
        { $set: updatedNote },
        { returnOriginal: false }
      );
      res.json(result.value);
    });

    // Delete a note route
    app.delete('/api/notes/:id', async (req, res) => {
      const noteId = req.params.id;
      // Delete note
      const result = await database.collection('notes').deleteOne({ _id:new ObjectId(noteId) });
      if (result.deletedCount === 1) {
        res.status(200).json({ message: 'Note deleted successfully' });
      } else {
        res.status(404).json({ error: 'Note not found' });
      }
    });

  
    
  app.get('/api/notes/:userId', async(req,res) =>{
      const userId = req.params.userId;
      console.log(userId)
     
      try{
        const notes = await Note.findOne({userId:userId});
        if(notes){
        res.status(200).json({"msg":"success",note:notes})}
        else{res.status(200).json("no note")}
    } catch(error){ console.error('Error retrieving notes:', error);
    res.status(500).json({ error: 'Internal server error' });}})

   
    app.get('/api/notes', async (req, res) => {
      try {
        // Access the notes collection directly
        const notesCollection = database.collection('notes');
    
        // Find all notes in the collection
        const notes = await notesCollection.find().toArray();
    
        if (notes.length > 0) {
          res.status(200).json({ message: 'Success', notes: notes });
        } else {
          res.status(200).json({ message: 'No notes found' });
        }
      } catch (error) {
        console.error('Error retrieving notes:', error);
        res.status(500).json({ error: 'Internal server error' });
      }
    });
    

    // Start the Express server
    app.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  } catch (error) {
    console.error('Error:', error);
  }
}
app.get('/', (req, res) => {
  res.send('Hello, World!');
});
// Start the server
main().catch(console.error);
