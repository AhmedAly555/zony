import 'coordinates_model.dart';

class SinglePudo {
  final int id;
  final String name;
  final String address;
  final String cityName;
  final String districtName;
  final String municipalLicense;
  final String partnerName;
  final double pointUsagePercentage;
  final String status;
  final int totalParcels;
  final int zoneId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CoordinatesModel coordinates;
  final List<String> gallery;
  final Map<String, dynamic> operatingHours;
  final List<String> supervisorNames;

  SinglePudo({
    required this.id,
    required this.name,
    required this.address,
    required this.cityName,
    required this.districtName,
    required this.municipalLicense,
    required this.partnerName,
    required this.pointUsagePercentage,
    required this.status,
    required this.totalParcels,
    required this.zoneId,
    required this.createdAt,
    required this.updatedAt,
    required this.coordinates,
    required this.gallery,
    required this.operatingHours,
    required this.supervisorNames,
  });

  factory SinglePudo.fromJson(Map<String, dynamic> json) {
    return SinglePudo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      cityName: json['city_name'] ?? '',
      districtName: json['district_name'] ?? '',
      municipalLicense: json['municipal_license'] ?? '',
      partnerName: json['partner_name'] ?? '',
      pointUsagePercentage: (json['point_usage_percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      totalParcels: json['total_parcels'] ?? 0,
      zoneId: json['zone_id'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      coordinates: CoordinatesModel.fromJson(json['coordinates'] ?? {}),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      operatingHours: (json['oprating_hours'] ?? {}) as Map<String, dynamic>,
      supervisorNames: (json['supervisor_names'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'city_name': cityName,
    'district_name': districtName,
    'municipal_license': municipalLicense,
    'partner_name': partnerName,
    'point_usage_percentage': pointUsagePercentage,
    'status': status,
    'total_parcels': totalParcels,
    'zone_id': zoneId,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'coordinates': coordinates.toJson(),
    'gallery': gallery,
    'oprating_hours': operatingHours,
    'supervisor_names': supervisorNames,
  };
}
