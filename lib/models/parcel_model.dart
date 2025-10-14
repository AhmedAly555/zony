/*
class Parcel {
  final int id;
  final int pudoId;
  final String courierId;
  final String clientName;
  final String cityName;
  final String zoneName;
  final String trackingNumber;
  final String status;
  final String receivingDate;

  Parcel({
    required this.id,
    required this.pudoId,
    required this.courierId,
    required this.clientName,
    required this.cityName,
    required this.zoneName,
    required this.trackingNumber,
    required this.status,
    required this.receivingDate,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'],
      pudoId: json['pudo_id'],
      courierId: json['courier_id'],
      clientName: json['client_name'],
      cityName: json['city_name'],
      zoneName: json['zone_name'],
      trackingNumber: json['tracking_number'],
      status: json['status'],
      receivingDate: json['receiving_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pudo_id': pudoId,
      'courier_id': courierId,
      'client_name': clientName,
      'city_name': cityName,
      'zone_name': zoneName,
      'tracking_number': trackingNumber,
      'status': status,
      'receiving_date': receivingDate,
    };
  }
}
*/

class Parcel {
  final int id;
  final int pudoId;
  final String courierId;
  final String clientName;
  final String cityName;
  final String zoneName;
  final String trackingNumber;
  final String status;
  final String receivingDate;

  // الحقول الجديدة من الإندبوينت الثانية
  final String? barcode;
  final String? customerPhoneNumber;
  final String? deliveringDate;
  final int? pickupPeriod;
  final String? receivingCode;
  final String? createdAt;
  final String? updatedAt;
  final dynamic images; // ممكن تبقى List أو null حسب الـ API

  Parcel({
    required this.id,
    required this.pudoId,
    required this.courierId,
    required this.clientName,
    required this.cityName,
    required this.zoneName,
    required this.trackingNumber,
    required this.status,
    required this.receivingDate,
    this.barcode,
    this.customerPhoneNumber,
    this.deliveringDate,
    this.pickupPeriod,
    this.receivingCode,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'],
      pudoId: json['pudo_id'],
      courierId: json['courier_id'],
      clientName: json['client_name'],
      cityName: json['city_name'],
      zoneName: json['zone_name'],
      trackingNumber: json['tracking_number'],
      status: json['status'],
      receivingDate: json['receiving_date'],
      barcode: json['barcode'],
      customerPhoneNumber: json['customer_phone_number'],
      deliveringDate: json['delivering_date'],
      pickupPeriod: json['pickup_period'],
      receivingCode: json['receiving_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pudo_id': pudoId,
      'courier_id': courierId,
      'client_name': clientName,
      'city_name': cityName,
      'zone_name': zoneName,
      'tracking_number': trackingNumber,
      'status': status,
      'receiving_date': receivingDate,
      'barcode': barcode,
      'customer_phone_number': customerPhoneNumber,
      'delivering_date': deliveringDate,
      'pickup_period': pickupPeriod,
      'receiving_code': receivingCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'images': images,
    };
  }
}

