import 'package:flutter/material.dart';
import './Sign_up.dart';
import './Log_in.dart';

void main() {
  runApp(MaterialApp(
    home: getStarted(),
  ));
}

class getStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Align gradient from top
            end: Alignment.bottomCenter, // to bottom
            colors: [
              Color(0xFFC7E31B), // Top color: C7E31B
              Color(0xFFB5C5D6)
                  .withOpacity(0.5), // Bottom color: B5C5D6 with 50% opacity
            ],
            stops: [0.0, 0.7],
            // Adjust stops to control the intensity towards the bottom
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align text to the center
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20.0),
              child: Text(
                'NoteWorthy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2CB1A1), // Set the text color to 2CB1A1
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 20.0),
              child: Text(
                'Let\'s Write',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Adjust other text styles as needed
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, bottom: 50.0),
              child: Text(
                'Thoughts For Tomorrow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Adjust other text styles as needed
                ),
              ),
            ),
            Image.asset(
              'assets/images/inkPen.png',
              height: 80, // Set the height
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF97B7B7))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    ); // Button onPressed logic
                  },
                  child: Text(
                    style: TextStyle(color: Color(0xFF000000)),
                    'Get Started',
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()),
                ); // Navigate to login screen or perform login action
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,
                    color: Color(0xFF2CB1A1),
                    // Set text color to blue to indicate it's a link
                    decoration: TextDecoration.underline, // Underline the text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
