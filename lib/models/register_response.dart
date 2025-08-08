//Not needed in mobile app now

import 'user_model.dart';

class RegisterResponse {
  final String status;
  final String message;
  final UserModel user;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.user,
  });

  // Convert a JSON map to a RegisterResponse object
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      user: UserModel.fromRegisterJson(json['user']),
    );
  }

  // Convert a RegisterResponse object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'user': user.toJson(),
    };
  }
}

// Usage
/*final responseJson = await getMockRegisterJson();
final registerResponse = RegisterResponse.fromJson(responseJson);

print(registerResponse.message); // User registered successfully
print(registerResponse.user.email); // test@example.com*/

