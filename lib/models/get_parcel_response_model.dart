import 'parcel_model.dart';

class ParcelResponse {
  final String status;
  final String message;
  final Parcel parcel;

  ParcelResponse({
    required this.status,
    required this.message,
    required this.parcel,
  });

  factory ParcelResponse.fromJson(Map<String, dynamic> json) {
    return ParcelResponse(
      status: json['status'],
      message: json['message'],
      parcel: Parcel.fromJson(json['parcel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'parcel': parcel.toJson(),
    };
  }
}
