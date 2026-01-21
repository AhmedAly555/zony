class ParcelByBarcodeModel {
  final int id;
  final String pudoAddress;
  final String pudoName;
  final String responsibleName;
  final String responsiblePhoneNumber;

  ParcelByBarcodeModel({
    required this.id,
    required this.pudoAddress,
    required this.pudoName,
    required this.responsibleName,
    required this.responsiblePhoneNumber,
  });

  factory ParcelByBarcodeModel.fromJson(Map<String, dynamic> json) {
    return ParcelByBarcodeModel(
      id: json['id'] ?? 0,
      pudoAddress: json['pudo_address'] ?? '',
      pudoName: json['pudo_name'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      responsiblePhoneNumber: json['responsible_phone_number'] ?? '',
    );
  }
}
