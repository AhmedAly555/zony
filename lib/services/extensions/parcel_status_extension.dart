import 'package:flutter/material.dart';

import '../enums/parcel_status_type.dart';

extension ParcelStatusTypeExtension on ParcelStatusType {
  /// Convert enum value to API string value
  String get apiValue {
    switch (this) {
      case ParcelStatusType.courierReceived:
        return 'courier_received';
      case ParcelStatusType.waitingConfirmation:
        return 'waiting_confirmation';
      case ParcelStatusType.pudoReceived:
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

  /// Convert API string to enum value
  static ParcelStatusType fromApiValue(String value) {
    switch (value) {
      case 'courier_received':
        return ParcelStatusType.courierReceived;
      case 'waiting_confirmation':
        return ParcelStatusType.waitingConfirmation;
      case 'PUDO_received':
        return ParcelStatusType.pudoReceived;
      case 'customer_received':
        return ParcelStatusType.customerReceived;
      case 'expired':
        return ParcelStatusType.expired;
      case 'expired_received':
        return ParcelStatusType.expiredReceived;
      case 'pending':
      default:
        return ParcelStatusType.pending;
    }
  }

  /// Display name for UI
  String get displayName {
    switch (this) {
      case ParcelStatusType.courierReceived:
        return 'Received';
      case ParcelStatusType.waitingConfirmation:
        return 'Waiting Confirmation';
      case ParcelStatusType.pudoReceived:
        return 'PUDO Received';
      case ParcelStatusType.customerReceived:
        return 'Customer Received';
      case ParcelStatusType.expired:
        return 'Expired';
      case ParcelStatusType.expiredReceived:
        return 'Expired Received';
      case ParcelStatusType.pending:
        return 'Pending';
    }
  }

  /// Color based on status for UI
  Color get color {
    switch (this) {
      case ParcelStatusType.courierReceived:
        return Colors.green;
      case ParcelStatusType.waitingConfirmation:
        return Colors.orange;
      case ParcelStatusType.pudoReceived:
        return Colors.blue;
      case ParcelStatusType.customerReceived:
        return Colors.teal;
      case ParcelStatusType.expired:
        return Colors.red;
      case ParcelStatusType.expiredReceived:
        return Colors.deepPurple;
      case ParcelStatusType.pending:
        return Colors.grey;
    }
  }
}
