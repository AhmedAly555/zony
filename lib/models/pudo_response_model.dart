import 'pudo_model.dart';

class PudoResponse {
  final String status;
  final String message;
  final int currentPage;
  final int? nextPage;
  final int? prevPage;
  final int totalPages;
  final int totalPudos;
  final List<Pudo> pudos;

  PudoResponse({
    required this.status,
    required this.message,
    required this.currentPage,
    this.nextPage,
    this.prevPage,
    required this.totalPages,
    required this.totalPudos,
    required this.pudos,
  });

  factory PudoResponse.fromJson(Map<String, dynamic> json) {
    return PudoResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      currentPage: json['current_page'] ?? 1,
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
      totalPages: json['total_pages'] ?? 1,
      totalPudos: json['total_pudos'] ?? 0,
      pudos: (json['pudos'] as List<dynamic>?)
          ?.map((e) => Pudo.fromJson(e))
          .toList() ??
          [],
    );
  }
}
