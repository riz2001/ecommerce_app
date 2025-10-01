import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var token = "".obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    // ✅ Debug prints to check exact values being sent
    Get.snackbar(
      "Debug Info",
      "Username: '${username.trim()}'\nPassword: '${password.trim()}'",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {
          "Content-Type": "application/json" // headers go here
        },
        body: jsonEncode({
          "username": username.trim(),
          "password": password.trim(),
        }),
      );

      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        token.value = data['token'];
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("Login Failed", "Invalid username or password");
      }

    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}