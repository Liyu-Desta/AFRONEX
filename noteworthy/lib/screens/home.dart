import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as MongoDart;
import 'package:noteworthy/models/note.dart';
import 'package:noteworthy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    String userId = "userId";
    _fetchNotes(userId);
  }

    Future<void> _deleteNoteDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Note'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {

                String? noteId = notes[index].id;
                if (noteId != null) {
                  await _deleteNote(noteId, index);
                                  setState(() {
                  notes.removeAt(index);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

Future<void> _deleteNote(String noteId, int index) async {
  final Uri url = Uri.parse('http://127.0.0.1:3000/api/notes/$noteId');
  final response = await http.delete(url);
  
  // if (response.statusCode == 204) {
  //   setState(() {
  //     notes.removeAt(index);
  //   });
  // }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(notes[index].title ?? 'No title'),
                subtitle: Text(notes[index].description ?? 'No content'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editNoteDialog(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteNoteDialog(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNoteDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _createNoteDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String content = contentController.text;

                await _saveNote(title, content);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editNoteDialog(int index) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    titleController.text = notes[index].title;
    contentController.text = notes[index].description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String title = titleController.text;
                String description = contentController.text;
                String? noteId = notes[index].id; // Update the type to String?
                String userId = notes[index].userId; // Retrieve the userId
                if (noteId != null) {
                  await _updateNote(
                    noteId,
                    title,
                    description,
                    userId,
                    index,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }


  Future<String?> getUserId(String username) async {
    final Uri url =
        Uri.parse('http://127.0.0.1:3000/api/users?username=$username');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      // Assuming the user ID is stored in a field called "userId"
      String? userId = userData['userId'];
      String tempUserId = userId ?? "";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", tempUserId);
      print(tempUserId);
      return userId;
    } else {
      return null;
    }
  }

  Future<void> _saveNote(
    String title,
    String description,
  ) async {
    final Uri url = Uri.parse('http://127.0.0.1:3000/api/notes');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'title': title,
          'description': description,
          'userId': userId,
        },
      ),
    );
    if (response.statusCode == 201 && userId != null) {
      _fetchNotes(userId); // Fetch notes again after saving
    } else {
      print('Error while saving note: ${response.statusCode}');
    }
  }

  Future<void> _updateNote(
    String noteId,
    String title,
    String description,
    String userId,
    int index,
  ) async {
    final Uri url = Uri.parse('http://127.0.0.1:3000/api/notes/$noteId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'title': title,
          'description': description,
          'userId': userId,
        },
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        notes[index].title = title;
        notes[index].description = description;
      });
    } else {
      print('Error while updating note: ${response.statusCode}');
    }
  }

  Future<void> _fetchNotes(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    final Uri url = Uri.parse('http://127.0.0.1:3000/api/notes?userId=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final notesData = jsonResponse['notes'];

      if (notesData == null || !(notesData is List)) {
        // Handle the case where notesData is null or not in the expected format
        print('Error: Invalid notes data');
        return;
      }

      List<Note> fetchedNotes = [];

      for (var noteData in notesData) {
        if (noteData is Map<String, dynamic>) {
          Note note = Note(
            id: noteData['_id'] ?? '',
            title: noteData['title'] ?? '',
            description: noteData['description'] ?? '',
            userId: noteData['userId'] ?? '',
          );
          fetchedNotes.add(note);
        }
      }

      setState(() {
        notes = fetchedNotes;
      });
    } else {
      print('Error while fetching notes: ${response.statusCode}');
    }
  }
}
