class ParcelByBarcodeModel {
  final int id;
  final String clientName;
  final String customerName;
  final String parcelBarcode;
  final String pudoAddress;
  final String pudoName;
  final String responsibleName;
  final String responsiblePhoneNumber;

  ParcelByBarcodeModel({
    required this.id,
    required this.clientName,
    required this.customerName,
    required this.parcelBarcode,
    required this.pudoAddress,
    required this.pudoName,
    required this.responsibleName,
    required this.responsiblePhoneNumber,
  });

  factory ParcelByBarcodeModel.fromJson(Map<String, dynamic> json) {
    return ParcelByBarcodeModel(
      id: json['id'] ?? 0,
      clientName: json['client_name'] ?? '',
      customerName: json['customer_name'] ?? '',
      parcelBarcode: json['parcel_barcode'] ?? '',
      pudoAddress: json['pudo_address'] ?? '',
      pudoName: json['pudo_name'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      responsiblePhoneNumber: json['responsible_phone_number'] ?? '',
    );
  }
}
