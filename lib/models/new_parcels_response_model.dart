
import 'new_parcels_model.dart';

class NewParcelsResponse {
  final int currentPage;
  final String message;
  final String? nextPage;
  final List<NewParcelPudoModel> parcels;
  final String? prevPage;
  final String status;
  final int totalPages;
  final int totalParcels;

  NewParcelsResponse({
    required this.currentPage,
    required this.message,
    required this.nextPage,
    required this.parcels,
    required this.prevPage,
    required this.status,
    required this.totalPages,
    required this.totalParcels,
  });

  factory NewParcelsResponse.fromJson(Map<String, dynamic> json) {
    return NewParcelsResponse(
      currentPage: json['current_page'] ?? 1,
      message: json['message'] ?? '',
      nextPage: json['next_page'],
      parcels: (json['parcels'] as List<dynamic>? ?? [])
          .map((e) => NewParcelPudoModel.fromJson(e))
          .toList(),
      prevPage: json['prev_page'],
      status: json['status'] ?? '',
      totalPages: json['total_pages'] ?? 1,
      totalParcels: json['total_parcels'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'message': message,
      'next_page': nextPage,
      'parcels': parcels.map((e) => e.toJson()).toList(),
      'prev_page': prevPage,
      'status': status,
      'total_pages': totalPages,
      'total_parcels': totalParcels,
    };
  }
}
