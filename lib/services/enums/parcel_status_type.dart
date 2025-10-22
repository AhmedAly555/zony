enum ParcelStatusType {
  courierReceived,
  inWarehouse,
  outForDelivery,
  delivered,
  returned,
  cancelled,
  expired,
}

extension ParcelStatusTypeExtension on ParcelStatusType {
  /// يحول الـ enum لقيمة النص اللي الـ API محتاجها
  String get apiValue {
    switch (this) {
      case ParcelStatusType.courierReceived:
        return 'courier_received';
      case ParcelStatusType.inWarehouse:
        return 'in_warehouse';
      case ParcelStatusType.outForDelivery:
        return 'out_for_delivery';
      case ParcelStatusType.delivered:
        return 'delivered';
      case ParcelStatusType.returned:
        return 'returned';
      case ParcelStatusType.cancelled:
        return 'cancelled';
      case ParcelStatusType.expired:
        return 'expired';
    }
  }
}
