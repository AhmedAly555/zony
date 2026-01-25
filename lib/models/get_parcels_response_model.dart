/*
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
*/


import 'package:zony/models/parcel_model.dart';

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
      message: json['message'] as String? ?? 'No message',
      status: json['status'] as String? ?? 'unknown',
      currentPage: json['current_page'] as int? ?? 1,
      nextPage: json['next_page'] as int?,
      prevPage: json['prev_page'] as int?,
      totalPages: json['total_pages'] as int? ?? 1,
      totalParcels: json['total_parcels'] as int? ?? 0,
      parcels: (json['parcels'] as List<dynamic>? ?? [])
          .map((e) => Parcel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'current_page': currentPage,
      'next_page': nextPage,
      'prev_page': prevPage,
      'total_pages': totalPages,
      'total_parcels': totalParcels,
      'parcels': parcels.map((p) => p.toJson()).toList(),
    };
  }
}
