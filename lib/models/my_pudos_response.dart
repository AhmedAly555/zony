import 'my_pudos_model.dart';

class MyPudosResponse {
  final String message;
  final String status;
  final int currentPage;
  final int totalPages;
  final int totalPudos;
  final dynamic nextPage;
  final dynamic prevPage;
  final List<MyPudosModel> pudos;

  MyPudosResponse({
    required this.message,
    required this.status,
    required this.currentPage,
    required this.totalPages,
    required this.totalPudos,
    required this.nextPage,
    required this.prevPage,
    required this.pudos,
  });

  factory MyPudosResponse.fromJson(Map<String, dynamic> json) {
    return MyPudosResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalPudos: json['total_pudos'] ?? 0,
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
      pudos: (json['pudos'] as List<dynamic>? ?? [])
          .map((e) => MyPudosModel.fromJson(e))
          .toList(),
    );
  }
}
