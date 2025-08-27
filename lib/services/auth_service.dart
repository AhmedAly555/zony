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

  // Register function with mock data(not needed)
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

// log out function
Future<void> logout() async {
  // if use shared preferences and SecureStorage
  // Delete the tokens
  // await storage.delete(key: 'access_token');
  // await storage.delete(key: 'refresh_token');

  // mock delay
  await Future.delayed(const Duration(milliseconds: 500));

  // لو فيه system notifications أو push topics
  // FirebaseMessaging.instance.deleteToken(); // لو بتستخدم FCM

}

 //log out ui
/*ElevatedButton(
  onPressed: () async {
    await authService.logout();

    // بعد المسح نروح لشاشة اللوجين ونمسح كل الهستوري
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  },
  child: const Text("Logout"),
)
*/
