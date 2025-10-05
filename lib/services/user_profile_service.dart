import '../models/profile_model.dart';
import '../models/profile_response_model.dart';
import '../services/base_api_service.dart';
import 'api_service.dart';
import 'shered_preferences/profile_storage.dart';

/// Service responsible for user-related API calls
class UserService {
  static final UserService instance = UserService._internal(ApiService.instance);

  final BaseApiService _api;

  UserService._internal(this._api);

  /// Fetch user profile from API and store it locally
  Future<ProfileResponse> getProfile() async {
    final data = await _api.get('/profile');
    final response = ProfileResponse.fromJson(data);

    // Save profile locally in SharedPreferences
    await ProfileStorage.saveProfile(response.profile);

    return response;
  }

  /// Load cached profile (useful when offline or before API call finishes)
  Future<Profile?> getCachedProfile() async {
    return await ProfileStorage.getProfile();
  }

  /// Clear all user-related local data (called during logout)
  Future<void> clearUserData() async {
    await ProfileStorage.clearProfile();
    await ApiService.instance.clearTokens();// clear token too
    //_api.clearAuthToken();
  }
}


//useeeeeeeeeeeeeeeeeegeeeeeeeeeeeeeeee
//usege online
/*
final profileResponse = await userService.getProfile();
print("Hello, ${profileResponse.profile.firstName}");
*/

//usege offline
/*
final cachedProfile = await userService.getCachedProfile();
if (cachedProfile != null) {
print("Cached user: ${cachedProfile.firstName}");
}
*/

//usege clear logout
/*
await userService.clearUserData();
*/

