import 'parcel_image_field_model.dart';

class UpdateParcelRequestModel {
  final String status;
  final String imageFieldName; // e.g. "warehouse_image"
  final ParcelImageFieldModel imageField;

  UpdateParcelRequestModel({
    required this.status,
    required this.imageFieldName,
    required this.imageField,
  });

  /// يرجع خريطة جاهزة للـ PATCH body:
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      imageFieldName: imageField.toJson(),
    };
  }
}
