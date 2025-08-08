import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/login_response.dart';
import '../models/base_response.dart';
import '../models/user_model.dart';

class AuthService {
  // login function with mock data
  Future<LoginResponse> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final jsonString =
    await rootBundle.loadString('lib/mock_data/mock_login_response.json');
    final jsonData = jsonDecode(jsonString);

    final validEmail = jsonData['valid_email'];
    final validPassword = jsonData['valid_password'];

    final inputEmail = email.trim().toLowerCase();
    final inputPassword = password.trim();

    // ✅ اطبع كل حاجة للمقارنة
    print('🔐 inputEmail: $inputEmail');
    print('🔐 inputPassword: $inputPassword');
    print('📄 validEmail: ${validEmail.toLowerCase()}');
    print('📄 validPassword: $validPassword');

    if (inputEmail != validEmail.toLowerCase() || inputPassword != validPassword) {
      throw Exception('Invalid email or password');
    }

    final responseData = jsonData['response'];
    return LoginResponse.fromJson(responseData);
  }

/*
  Future<LoginResponse> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final jsonString =
    await rootBundle.loadString('lib/mock_data/mock_login_response.json');
    final jsonData = jsonDecode(jsonString);

    final validEmail = jsonData['valid_email'];
    final validPassword = jsonData['valid_password'];

    if (email != validEmail || password != validPassword) {
      throw Exception('Invalid email or password');
    }

// if login success
    final responseData = jsonData['response'];
    return LoginResponse.fromJson(responseData);
  }*/
}
