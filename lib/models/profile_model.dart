/// Profile model
/// Represents the user profile object returned from API
class Profile {
  final String? avatar;
  final String? birthDate;
  final String? city;
  final String? country;
  final String email;
  final String firstName;
  final String? gender;
  final String id;
  final String? identity;
  final bool isActive;
  final String? lastLogin;
  final String lastName;
  final String? phoneNumber;
  final String username;

  Profile({
    this.avatar,
    this.birthDate,
    this.city,
    this.country,
    required this.email,
    required this.firstName,
    this.gender,
    required this.id,
    this.identity,
    required this.isActive,
    this.lastLogin,
    required this.lastName,
    this.phoneNumber,
    required this.username,
  });

  /// Factory constructor to create Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      avatar: json['avatar'],
      birthDate: json['birth_date'],
      city: json['city'],
      country: json['country'],
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      gender: json['gender'],
      id: json['id'] ?? '',
      identity: json['identity'],
      isActive: json['is_active'] ?? false,
      lastLogin: json['last_login'],
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'],
      username: json['username'] ?? '',
    );
  }

  /// Convert Profile back to JSON (useful if we need to send it somewhere)
  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar,
      "birth_date": birthDate,
      "city": city,
      "country": country,
      "email": email,
      "first_name": firstName,
      "gender": gender,
      "id": id,
      "identity": identity,
      "is_active": isActive,
      "last_login": lastLogin,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "username": username,
    };
  }
}
