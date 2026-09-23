import 'courier_stop_parcel_model.dart';
import 'courier_stop_place_model.dart';
import 'courier_stop_window_model.dart';

class CourierStopModel {
  final String action;
  final String placeType;
  final CourierStopPlaceModel? place;
  final CourierStopWindowModel? window;
  final int parcelCount;
  final List<CourierStopParcelModel> parcels;

  CourierStopModel({
    required this.action,
    required this.placeType,
    this.place,
    this.window,
    required this.parcelCount,
    required this.parcels,
  });

  factory CourierStopModel.fromJson(Map<String, dynamic> json) {
    return CourierStopModel(
      action: json['action'] ?? '',
      placeType: json['place_type'] ?? '',
      place: json['place'] != null
          ? CourierStopPlaceModel.fromJson(json['place'])
          : null,
      window: json['window'] != null
          ? CourierStopWindowModel.fromJson(json['window'])
          : null,
      parcelCount: json['parcel_count'] ?? 0,
      parcels: (json['parcels'] as List<dynamic>? ?? [])
          .map((e) => CourierStopParcelModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'action': action,
        'place_type': placeType,
        'place': place?.toJson(),
        'window': window?.toJson(),
        'parcel_count': parcelCount,
        'parcels': parcels.map((e) => e.toJson()).toList(),
      };
}
