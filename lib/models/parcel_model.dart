/*

class Parcel {
  final String id;
  final String? pudoId;
  final String? courierId;
  final String clientName;
  final String? cityName;
  final String? zoneName;
  final String trackingNumber;
  final String status;
  final String? receivingDate;

  // New fields from the second endpoint
  final String? barcode;
  final String? customerPhoneNumber;
  final String? deliveringDate;
  final int? pickupPeriod;
  final String? receivingCode;
  final String? createdAt;
  final String? updatedAt;
  final dynamic images;

  Parcel({
    required this.id,
    this.pudoId,
    required this.clientName,
    this.cityName,
    this.zoneName,
    required this.trackingNumber,
    required this.status,
    this.receivingDate,
    this.courierId,
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
      id: json['id'].toString(),
      pudoId: json['pudo_id'].toString(),
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

*/
class Parcel {
  final int id;
  final int? pudoId;
  final String? courierId;
  final String clientName;
  final String? cityName;
  final String? zoneName;
  final String trackingNumber;
  final String status;
  final String? receivingDate;
  final String? parcelBarcode;
  final String? customerName;

  // images ممكن تكون map أو object معقد → نعامله كـ Map مؤقتًا
  final Map<String, dynamic>? images;

  Parcel({
    required this.id,
    this.pudoId,
    this.courierId,
    required this.clientName,
    this.cityName,
    this.zoneName,
    required this.trackingNumber,
    required this.status,
    this.receivingDate,
    this.parcelBarcode,
    this.customerName,
    this.images,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      pudoId: json['pudo_id'] is int
          ? json['pudo_id'] as int?
          : int.tryParse(json['pudo_id']?.toString() ?? ''),
      courierId: json['courier_id']?.toString(),
      clientName: json['client_name'] as String? ?? 'غير معروف',
      cityName: json['city_name']?.toString(),
      zoneName: json['zone_name']?.toString(),
      trackingNumber: json['tracking_number'] as String? ?? '',
      status: json['status'] as String? ?? 'unknown',
      receivingDate: json['receiving_date']?.toString(),
      parcelBarcode: json['parcel_barcode']?.toString(),
      customerName: json['customer_name']?.toString(),
      images: json['images'] is Map<String, dynamic>
          ? json['images'] as Map<String, dynamic>?
          : null,
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
      'parcel_barcode': parcelBarcode,
      'customer_name': customerName,
      'images': images,
    };
  }

  // if we want to extract image helper methods
  /*String? get warehouseImageUrl => images?['warehouse_image']?['url']?.toString();
  String? get pudoImageUrl => images?['pudo_image']?['url']?.toString();*/
}
