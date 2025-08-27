
import 'user_role.dart';

class UserModel {
  final String? userId;
  final String? username;
  final String email;
  final UserRole? role;
  final String? lastLogin;


  UserModel({
    this.userId,
    this.username,
    required this.email,
    required this.role,
    this.lastLogin,
  });

  // for register (not needed in mobile app now)
  factory UserModel.fromRegisterJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  // for login
  factory UserModel.fromLoginJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: parseUserRole(json['role']),
      lastLogin: json['last_login'] ?? '',
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'role': role,
      'last_login': lastLogin,
    };
  }
}

// convert role stringAPI to enum
UserRole? parseUserRole(String? roleString) {
  switch (roleString?.toLowerCase()) {
    case 'zony couriers':
      return UserRole.zonyCouriers;
    case 'couriers':
      return UserRole.couriers;
    case 'podu':
      return UserRole.podu;
    default:
      return null;
  }
}
