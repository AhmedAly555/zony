enum ParcelStatusType {
  courierReceived,
  waitingConfirmation,
  PUDOReceived,
  customerReceived,
  expired,
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
      case ParcelStatusType.pending:
        return 'pending';
    }
  }
}
