import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noteworthy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:3000/api/users';

  // Method to register a new user
  static Future<bool> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'), // Adjust the endpoint as needed
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()), // Convert user object to JSON string
    );

    if (response.statusCode == 201) {
      // User registered successfully
      return true;
    } else {
      // Registration failed
      return false;
    }
  }

  // Method to login user
  static Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // Adjust the endpoint as needed
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // User logged in successfully
      // You can handle the token received from the server here
      var userData = json.decode(response.body);
      String? userId = userData['userId'];
      String tempUserId = userId ?? "";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", tempUserId);
      return true;
    } else {
      // Login failed
      return false;
    }
  }
}
