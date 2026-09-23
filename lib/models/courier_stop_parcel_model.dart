class CourierStopParcelModel {
  final String? source;
  final String id;
  final String? trackingRef;
  final String? trackingNumber;
  final String? barcode;
  final String? status;
  final String? recipientName;

  CourierStopParcelModel({
    this.source,
    required this.id,
    this.trackingRef,
    this.trackingNumber,
    this.barcode,
    this.status,
    this.recipientName,
  });

  factory CourierStopParcelModel.fromJson(Map<String, dynamic> json) {
    return CourierStopParcelModel(
      source: json['source'],
      id: json['id'] is String ? json['id'] as String : json['id']?.toString() ?? '',
      trackingRef: json['tracking_ref'],
      trackingNumber: json['tracking_number'],
      barcode: json['barcode'],
      status: json['status'],
      recipientName: json['recipient_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'source': source,
        'id': id,
        'tracking_ref': trackingRef,
        'tracking_number': trackingNumber,
        'barcode': barcode,
        'status': status,
        'recipient_name': recipientName,
      };
}
