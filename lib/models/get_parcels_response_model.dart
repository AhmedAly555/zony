import 'parcel_model.dart';

class ParcelsResponse {
  final String message;
  final String status;
  final int currentPage;
  final int? nextPage;
  final int? prevPage;
  final int totalPages;
  final int totalParcels;
  final List<Parcel> parcels;

  ParcelsResponse({
    required this.message,
    required this.status,
    required this.currentPage,
    this.nextPage,
    this.prevPage,
    required this.totalPages,
    required this.totalParcels,
    required this.parcels,
  });

  factory ParcelsResponse.fromJson(Map<String, dynamic> json) {
    return ParcelsResponse(
      message: json['message'],
      status: json['status'],
      currentPage: json['current_page'],
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
      totalPages: json['total_pages'],
      totalParcels: json['total_parcels'],
      parcels: (json['parcels'] as List<dynamic>)
          .map((e) => Parcel.fromJson(e))
          .toList(),
    );
  }
}
