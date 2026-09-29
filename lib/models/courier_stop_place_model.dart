import 'coordinates_model.dart';

class CourierStopPlaceModel {
  final String name;
  final String? phoneNumber;
  final String? address;
  final CoordinatesModel? coordinates;

  CourierStopPlaceModel({
    required this.name,
    this.phoneNumber,
    this.address,
    this.coordinates,
  });

  factory CourierStopPlaceModel.fromJson(Map<String, dynamic> json) {
    return CourierStopPlaceModel(
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'],
      address: json['address'],
      coordinates: json['coordinates'] != null
          ? CoordinatesModel.fromJson(json['coordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_number': phoneNumber,
        'address': address,
        'coordinates': coordinates?.toJson(),
      };
}
