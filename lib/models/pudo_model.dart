class Pudo {
  final int id;
  final String name;
  final String address;
  final Map<String, dynamic> coordinates;
  final Map<String, dynamic> operatingHours;
  final String municipalLicense;
  final List<dynamic> gallery;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pudo({
    required this.id,
    required this.name,
    required this.address,
    required this.coordinates,
    required this.operatingHours,
    required this.municipalLicense,
    required this.gallery,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pudo.fromJson(Map<String, dynamic> json) {
    return Pudo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      coordinates: json['coordinates'] ?? {},
      operatingHours: json['oprating_hours'] ?? {},
      municipalLicense: json['municipal_license'] ?? '',
      gallery: json['gallery'] ?? [],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'coordinates': coordinates,
      'oprating_hours': operatingHours,
      'municipal_license': municipalLicense,
      'gallery': gallery,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
