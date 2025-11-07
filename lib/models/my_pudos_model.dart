import 'coordinates_model.dart';

class MyPudosModel {
  final int id;
  final String name;
  final String address;
  final String municipalLicense;
  final CoordinatesModel coordinates;
  final List<dynamic> gallery;
  final Map<String, dynamic> operatingHours;
  final String createdAt;
  final String updatedAt;

  MyPudosModel({
    required this.id,
    required this.name,
    required this.address,
    required this.municipalLicense,
    required this.coordinates,
    required this.gallery,
    required this.operatingHours,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyPudosModel.fromJson(Map<String, dynamic> json) {
    return MyPudosModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      municipalLicense: json['municipal_license'] ?? '',
      coordinates: CoordinatesModel.fromJson(json['coordinates'] ?? {}),
      gallery: json['gallery'] ?? [],
      operatingHours: json['oprating_hours'] ?? {},
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'municipal_license': municipalLicense,
    'coordinates': coordinates.toJson(),
    'gallery': gallery,
    'oprating_hours': operatingHours,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
