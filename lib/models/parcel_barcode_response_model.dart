import 'package:zony/models/parcel_barcode_model.dart';

class ParcelByBarcodeResponse {
  final int currentPage;
  final String message;
  final String? nextPage;
  final List<ParcelByBarcodeModel> parcels;
  final String? prevPage;
  final String status;
  final int totalPages;
  final int totalParcels;

  ParcelByBarcodeResponse({
    required this.currentPage,
    required this.message,
    required this.nextPage,
    required this.parcels,
    required this.prevPage,
    required this.status,
    required this.totalPages,
    required this.totalParcels,
  });

  factory ParcelByBarcodeResponse.fromJson(Map<String, dynamic> json) {
    return ParcelByBarcodeResponse(
      currentPage: json['current_page'] ?? 1,
      message: json['message'] ?? '',
      nextPage: json['next_page'],
      parcels: (json['parcels'] as List<dynamic>? ?? [])
          .map((e) => ParcelByBarcodeModel.fromJson(e))
          .toList(),
      prevPage: json['prev_page'],
      status: json['status'] ?? '',
      totalPages: json['total_pages'] ?? 1,
      totalParcels: json['total_parcels'] ?? 0,
    );
  }
}
