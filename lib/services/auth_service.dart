import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/login_response.dart';
import '../models/base_response.dart';
import '../models/user_model.dart';

class AuthService {
  // Login function with mock data
  Future<LoginResponse> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final jsonString =
    await rootBundle.loadString('lib/mock_data/mock_login_response.json');
    final jsonData = jsonDecode(jsonString);

    final validEmail = jsonData['valid_email'];
    final validPassword = jsonData['valid_password'];

    final inputEmail = email.trim().toLowerCase();
    final inputPassword = password.trim();

    /*print('inputEmail: $inputEmail');
    print('inputPassword: $inputPassword');
    print('validEmail: ${validEmail.toLowerCase()}');
    print('validPassword: $validPassword');*/

    if (inputEmail != validEmail.toLowerCase() || inputPassword != validPassword) {
      throw Exception('Invalid email or password');
    }

    final responseData = jsonData['response'];
    return LoginResponse.fromJson(responseData);
  }

  // Register function with mock data
  Future<BaseResponse> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    final jsonString = await rootBundle
        .loadString('lib/mock_data/mock_reset_password_response.json');
    final jsonData = jsonDecode(jsonString);

    final validEmail = jsonData['valid_email'];

    if (email != validEmail) {
      throw Exception("Email not found");
    }

    return BaseResponse.fromJson({
      "status": jsonData['status'],
      "message": jsonData['message']
    });
  }


}
