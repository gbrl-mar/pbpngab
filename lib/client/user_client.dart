import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/user.dart'; // Import the User class

class UserClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/users'; // Adjust the endpoint as necessary

  // Login method
  static Future<bool> login(String email, String password) async {
    try {
      var response = await post(
        Uri.http(url, '$endpoint/login'), // Adjust the endpoint for login
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      // Check if the response indicates a successful login
      if (response.statusCode == 200) {
        return true; // Login successful
      } else {
        return false; // Login failed
      }
    } catch (e) {
      return false; // Handle error
    }
  }

  // Create method
  static Future<bool> create(User user) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      return response.statusCode == 201; // HTTP 201 Created
    } catch (e) {
      return false; // Handle error
    }
  }
}
