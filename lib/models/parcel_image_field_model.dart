class ParcelImageFieldModel {
  final String url;
  final String timestamp;
  final LocationModel? location;

  ParcelImageFieldModel({
    required this.url,
    required this.timestamp,
    this.location,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "url": url,
      "timestamp": timestamp,
    };
    if (location != null) {
      map["location"] = location!.toJson();
    }
    return map;
  }
}

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
