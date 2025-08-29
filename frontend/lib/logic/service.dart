import 'package:frontend/const/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Login user
  static Future<String> loginUser(String username, String password) async {
    //initialieze shared preference

    final prefs = await SharedPreferences.getInstance();

    try {
      final uri = Uri.parse("$url/login").replace(queryParameters: {
        "username": username,
        "password": password,
      });

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        await prefs.setString('accessToken', body["accessToken"]);
        await prefs.setString('refreshToken', body["refreshToken"]);
        await prefs.setBool('isLoggedIn', true);

        return "sucsess";
      } else if (response.statusCode == 404) {
        return "User not found";
      } else if (response.statusCode == 401) {
        return "Invalid password";
      }

      return "Your server Problem";
    } catch (e) {
      return "Your server Problem";
    }
  }

  // Register user

  static Future<String> registerUser(String username, String password) async {
    //initialieze shared preference
    final prefs = await SharedPreferences.getInstance();

    try {
      final uri = Uri.parse("$url/register").replace(queryParameters: {
        "username": username,
        "password": password,
      });

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 201) {
        var body = jsonDecode(response.body);
        await prefs.setString('accessToken', body["accessToken"]);
        await prefs.setString('refreshToken', body["refreshToken"]);
        await prefs.setBool('isLoggedIn', true);

        return "sucsess";
      } else if (response.statusCode == 409) {
        return "Username already taken";
      }

      return "Your server Problem";
    } catch (e) {
      return "Your server Problem";
    }
  }
}
