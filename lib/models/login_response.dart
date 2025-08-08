
import 'user_model.dart';

class LoginResponse {
  final String status;
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      user: UserModel.fromLoginJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user.toJson(),
    };
  }
}
