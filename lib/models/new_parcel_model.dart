/*
class NewParcelPudoModel {
  final int id;
  final String pudoAddress;
  final String pudoName;
  final String responsibleName;
  final String responsiblePhoneNumber;

  NewParcelPudoModel({
    required this.id,
    required this.pudoAddress,
    required this.pudoName,
    required this.responsibleName,
    required this.responsiblePhoneNumber,
  });

  factory NewParcelPudoModel.fromJson(Map<String, dynamic> json) {
    return NewParcelPudoModel(
      id: json['id'] ?? 0,
      pudoAddress: json['pudo_address'] ?? '',
      pudoName: json['pudo_name'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      responsiblePhoneNumber: json['responsible_phone_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pudo_address': pudoAddress,
      'pudo_name': pudoName,
      'responsible_name': responsibleName,
      'responsible_phone_number': responsiblePhoneNumber,
    };
  }
}
*/

class NewParcelPudoModel {
  final int id;
  final String clientName;
  final String customerName;
  final String customerPhoneNumber;
  final String parcelBarcode;
  final String pudoAddress;
  final String pudoName;
  final String responsibleName;
  final String responsiblePhoneNumber;
  final String status;

  NewParcelPudoModel({
    required this.id,
    required this.clientName,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.parcelBarcode,
    required this.pudoAddress,
    required this.pudoName,
    required this.responsibleName,
    required this.responsiblePhoneNumber,
    required this.status,
  });

  factory NewParcelPudoModel.fromJson(Map<String, dynamic> json) {
    return NewParcelPudoModel(
      id: json['id'] ?? 0,
      clientName: json['client_name'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerPhoneNumber: json['customer_phone_number'] ?? '',
      parcelBarcode: json['parcel_barcode'] ?? '',
      pudoAddress: json['pudo_address'] ?? '',
      pudoName: json['pudo_name'] ?? '',
      responsibleName: json['responsible_name'] ?? '',
      responsiblePhoneNumber: json['responsible_phone_number'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_name': clientName,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'parcel_barcode': parcelBarcode,
      'pudo_address': pudoAddress,
      'pudo_name': pudoName,
      'responsible_name': responsibleName,
      'responsible_phone_number': responsiblePhoneNumber,
      'status': status,
    };
  }
}