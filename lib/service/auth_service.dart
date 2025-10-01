import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const baseUrl = "https://fakestoreapi.com/auth/login";

  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"]; // returns JWT token
    } else {
      return null;
    }
  }
}
