import 'courier_stop_model.dart';

class CourierPlacesResponseModel {
  final String status;
  final String message;
  final int totalStops;
  final List<CourierStopModel> stops;

  CourierPlacesResponseModel({
    required this.status,
    required this.message,
    required this.totalStops,
    required this.stops,
  });

  factory CourierPlacesResponseModel.fromJson(Map<String, dynamic> json) {
    return CourierPlacesResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      totalStops: json['total_stops'] ?? 0,
      stops: (json['stops'] as List<dynamic>? ?? [])
          .map((e) => CourierStopModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'total_stops': totalStops,
        'stops': stops.map((e) => e.toJson()).toList(),
      };
}
