import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';

class AuthService {
  // Simulate a database where user information is stored
  List<User> users = [];

  // Function to register a new user
  Future<bool> registerUser(User user) async {
    try {
      // Check if the username or email is already registered
      if (users.any((u) => u.username == user.username || u.email == user.email)) {
        // Username or email already exists, return false to indicate registration failure
        return false;
      }

      // User registration successful, add the user to the list
      users.add(user);
      return true;
    } catch (e) {
      // Error occurred during registration, return false to indicate failure
      return false;
    }
  }

  // Function to log in a user
  Future<String?> loginUser(String username, String password) async {
    // Find the user with the provided username
    final user = users.firstWhere((u) => u.username == username, orElse: () => User(username: '', email: '', birthDate: '0', password: ''));

    if (user.username.isNotEmpty && user.password == password) {
      // User found and password matches, return a token or session identifier
      // For simplicity, return the user ID as the token
      final token = user.username;
      // Store the token in local storage
      await storeToken(token);
      return token;
    } else {
      // User not found or password incorrect, return null
      return null;
    }
  }

  // Function to store the token in local storage
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Function to retrieve the token from local storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Function to delete the token from local storage
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Function to check if a user is logged in
  Future<bool> isLoggedIn() async {
    // Check if a token exists in local storage
    final token = await getToken();
    return token != null;
  }

  // Function to log out a user (not necessary for this simulation)
  void logout() {
    // Delete the token from local storage
    deleteToken();
  }
}
