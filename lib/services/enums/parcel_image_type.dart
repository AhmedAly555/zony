enum ParcelImageType {
  warehouseImage,
  pudoImage,
  customerImage,
  expiredImage,
}

extension ParcelImageTypeExtension on ParcelImageType {
  /// يحول الـ enum لقيمة النص اللي الـ API محتاجها
  String get apiValue {
    switch (this) {
      case ParcelImageType.warehouseImage:
        return 'warehouse_image';
      case ParcelImageType.pudoImage:
        return 'pudo_image';
      case ParcelImageType.customerImage:
        return 'customer_image';
      case ParcelImageType.expiredImage:
        return 'expired_image';
    }
  }
}
