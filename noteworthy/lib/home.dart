import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFC7E31B), // Top color: C7E31B
                    Color(0xFFB5C5D6), // Bottom color: B5C5D6
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/inkPen.png'), // Replace with your image asset
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        // Add logic to handle camera button tap
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Tasks'),
              onTap: () {
                // Handle List 1 tap
              },
            ),
            ListTile(
              title: Text('Special Dates'),
              onTap: () {
                // Handle List 2 tap
              },
            ),
            ListTile(
              title: Text('Diary'),
              onTap: () {
                // Handle List 3 tap
              },
            ),
            ListTile(
              title: Text('BirthDay'),
              onTap: () {
                // Handle List 4 tap
              },
            ),
            ListTile(
              title: Text('Notes'),
              onTap: () {
                // Handle List 5 tap
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                // Handle List 6 tap
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
