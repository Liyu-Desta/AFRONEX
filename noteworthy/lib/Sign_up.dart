import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? _image;

Future<void> _pickImage() async {
  try {
    if (!kIsWeb) {
      final status = await Permission.photos.status;
      if (!status.isGranted) {
        print('Permission not granted for accessing photos');
        // Handle the case where permission is not granted
        return;
      }
    }

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  } catch (e) {
    print('Error picking image: $e');
    // Handle the error as needed, e.g., show a toast or display an error message
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 15.0, bottom: 10.0),
                child: Text(
                  'NoteWorthy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2CB1A1), // Set the text color to 2CB1A1
                  ),
                ),
              ),
              SizedBox(height: 20), // Add some space below the 'NoteWorthy' text
              Stack(
                alignment: Alignment.center,
                children: [
                  // Circular placeholder for profile photo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: _image != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 50,
                          )
                        : Icon(
                            Icons.person, // You can replace this with the user's actual profile photo
                            size: 50,
                            color: Colors.black,
                          ),
                  ),
                  // Plus button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFB5C5D6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10), // Add some space between the circle and the text
              Text(
                'Add Profile Photo',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 20), // Add spacing before the first input field
              Container(
                height: 50, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB5C5D6),
                      labelText: 'Username',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between input fields
              Container(
                height: 50, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB5C5D6),
                      labelText: 'Birth Date',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between input fields
              Container(
                height: 50, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB5C5D6),
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between input fields
              Container(
                height: 50, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB5C5D6),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add spacing before the button
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFC7E31B)),
                ),
                onPressed: () {
                  // Add onPressed logic for the 'Sign Up' button
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
