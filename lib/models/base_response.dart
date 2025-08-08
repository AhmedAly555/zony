// base_response for logout and reset password

class BaseResponse {
  final String status;
  final String message;

  BaseResponse({
    required this.status,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}

// usage fot logout
/*final res = BaseResponse.fromJson(jsonData);
print(res.message); // Logout successful*/

// usage for reset password
/*final res = BaseResponse.fromJson(jsonData);
print(res.message); // Password reset email sent successfully*/

