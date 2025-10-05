
import 'profile_model.dart';

/// ProfileResponse model
/// Represents the whole API response for /profile endpoint
class ProfileResponse {
  final String message;
  final String status;
  final Profile profile;

  ProfileResponse({
    required this.message,
    required this.status,
    required this.profile,
  });

  /// Factory constructor to parse JSON into ProfileResponse
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      profile: Profile.fromJson(json['profile'] ?? {}),
    );
  }

  /// Convert ProfileResponse back to JSON
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "status": status,
      "profile": profile.toJson(),
    };
  }
}
