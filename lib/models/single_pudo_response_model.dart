import 'single_pudo_model.dart';

class SinglePudoResponse {
  final String message;
  final String status;
  final SinglePudo pudo;

  SinglePudoResponse({
    required this.message,
    required this.status,
    required this.pudo,
  });

  factory SinglePudoResponse.fromJson(Map<String, dynamic> json) {
    return SinglePudoResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      pudo: SinglePudo.fromJson(json['pudo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'pudo': pudo.toJson(),
  };
}
