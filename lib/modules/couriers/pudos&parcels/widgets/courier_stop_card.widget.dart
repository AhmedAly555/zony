import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../models/courier_stop_model.dart';
import '../../../../theme/app_colors.theme.dart';

class CourierStopCard extends StatelessWidget {
  final CourierStopModel stop;
  final VoidCallback onTap;

  const CourierStopCard({super.key, required this.stop, required this.onTap});

  String _placeTypeLabel(BuildContext context) {
    switch (stop.placeType) {
      case 'warehouse':
        return S.of(context).warehouse;
      case 'customer':
        return S.of(context).customer;
      case 'pudo':
        return S.of(context).pudoPlaceType;
      case 'unassigned':
        return S.of(context).unassignedStop;
      default:
        return stop.placeType;
    }
  }

  String _title(BuildContext context) {
    final name = stop.place?.name;
    if (name != null && name.isNotEmpty) return name;
    return S.of(context).unassignedStop;
  }

  String _subtitle(BuildContext context) {
    final address = stop.place?.address;
    if (address != null && address.isNotEmpty) return address;
    if (stop.place == null && stop.parcels.isNotEmpty) {
      final parcel = stop.parcels.first;
      final tracking = parcel.trackingNumber ?? parcel.trackingRef ?? parcel.barcode;
      if (tracking != null) return '#$tracking';
    }
    return S.of(context).noAddressAvailable;
  }

  String? _windowLabel() {
    final window = stop.window;
    if (window == null) return null;
    final dateOrSlot = window.date ?? window.slotCode;
    final parts = <String>[
      if (dateOrSlot != null) dateOrSlot,
      if (window.fromTime != null && window.toTime != null)
        '${window.fromTime}-${window.toTime}',
    ];
    if (parts.isEmpty) return null;
    return parts.join(' | ');
  }

  @override
  Widget build(BuildContext context) {
    final windowLabel = _windowLabel();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: const Color(0xFFdbd0eb),
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/podus_location.svg',
                    width: 22,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.zonyPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title(context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _subtitle(context),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.zonyBackground,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _placeTypeLabel(context),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.zonyPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF4F4F4), thickness: 1, height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset('assets/svgs/bag_icon.svg', width: 16, height: 16),
                const SizedBox(width: 6),
                Text(
                  '${stop.parcelCount} ${S.of(context).parcels}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                if (windowLabel != null) ...[
                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    'assets/svgs/time_icon_with_background.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      windowLabel,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
