import 'package:flutter/material.dart';
import 'package:noteworthy/screens/home.dart';
import 'package:noteworthy/services/api_service.dart';

void main() {
  runApp(MaterialApp(home: LogIn()));
}

class LogIn extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 15.0, bottom: 10.0),
              child: Text(
                'NoteWorthy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2CB1A1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 50.0),
              child: Image.asset(
                'assets/images/inkPen.png',
                height: 80,
              ),
            ),
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _usernameController,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFB5C5D6),
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
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
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFC7E31B)),
              ),
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                bool authenticated = await ApiService.loginUser(username, password);

                if (authenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } else {
                  // Handle login failure, show error message, etc.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Login Failed'),
                        content: Text('Invalid username or password.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
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
