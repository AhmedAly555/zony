import 'api_service.dart';

class UpdateProfileService {
  // ---------------- Singleton ----------------
  static final UpdateProfileService instance = UpdateProfileService._internal();
  UpdateProfileService._internal();

  final _api = ApiService.instance;

  /// Update user profile (PATCH /profile)
  /// Only non-null fields will be sent to API
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) async {
    final Map<String, dynamic> reqBody = {};

    if (firstName != null) {
      reqBody['first_name'] = firstName;
    }

    if (lastName != null) {
      reqBody['last_name'] = lastName;
    }

    if (email != null) {
      reqBody['email'] = email;
    }

    if (phoneNumber != null) {
      reqBody['phone_number'] = phoneNumber;
    }

    // حماية زيادة: مينفعش نبعث PATCH فاضي
    if (reqBody.isEmpty) {
      return;
    }

    await _api.patchJson('/profile', reqBody);
  }
}
