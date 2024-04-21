import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LogIn()));
}

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 15.0, bottom: 10.0),
              child: Text(
                'NoteWorthy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2CB1A1), // Set the text color to 2CB1A1
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 50.0),
              child: Image.asset(
                'assets/images/inkPen.png',
                height: 80, // Set the height
              ),
            ),
            Container(
              width: 200, // Adjust the width as needed
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: TextField(
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFB5C5D6),
                    labelText: 'User name',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Add spacing between input fields
            Container(
              width: 200, // Adjust the width as needed
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  style: TextStyle(fontSize: 24),
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
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
