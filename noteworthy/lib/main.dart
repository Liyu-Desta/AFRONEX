import 'package:flutter/material.dart';
import 'package:noteworthy/screens/getStarted.dart'; // Import your initial screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteWorthy',
      theme: ThemeData(
        primaryColor: Color(0xFF2CB1A1), // Set your primary theme color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: getStarted(), // Set your initial screen here
    );
  }
}
