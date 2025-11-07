/*
enum ParcelStatusType {
  courierReceived,
  waitingConfirmation,
  PUDOReceived,
  customerReceived,
  expired,
  expiredReceived,
  pending,
}

extension ParcelStatusTypeExtension on ParcelStatusType {
  // convert enum to string for API
  String get apiValue {
    switch (this) {
      case ParcelStatusType.courierReceived:
        return 'courier_received';
      case ParcelStatusType.waitingConfirmation:
        return 'waiting_confirmation';
      case ParcelStatusType.PUDOReceived:
        return 'PUDO_received';
      case ParcelStatusType.customerReceived:
        return 'customer_received';
      case ParcelStatusType.expired:
        return 'expired';
      case ParcelStatusType.expiredReceived:
        return 'expired_received';
      case ParcelStatusType.pending:
        return 'pending';
    }
  }
}
*/
enum ParcelStatusType {
  courierReceived,
  waitingConfirmation,
  pudoReceived,
  customerReceived,
  expired,
  expiredReceived,
  pending,
}

