import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

import '../../../../models/courier_stop_model.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../theme/app_colors.theme.dart';
import '../../../../views/widgets/bottom_sheet/componants_bottom_sheet.widgets.dart';
import '../../../../views/widgets/bottom_sheet_container.dart';
import 'courier_stop_card.widget.dart';
import 'stops_map_view.widget.dart';

/// Maps stops to map points, skipping stops with no place/coordinates.
/// Missing lat/lng is parsed as 0 by CoordinatesModel, so (0,0) is treated as missing.
List<MapMarkerPoint<CourierStopModel>> courierStopsToMapPoints(
  List<CourierStopModel> stops,
) {
  final points = <MapMarkerPoint<CourierStopModel>>[];
  for (final stop in stops) {
    final coordinates = stop.place?.coordinates;
    if (coordinates == null) continue;
    if (coordinates.latitude == 0 || coordinates.longitude == 0) continue;
    points.add(
      MapMarkerPoint(
        position: LatLng(coordinates.latitude, coordinates.longitude),
        data: stop,
      ),
    );
  }
  return points;
}

class CourierStopMapMarker extends StatelessWidget {
  const CourierStopMapMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.zonyPrimary, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SvgPicture.asset(
        'assets/svgs/podus_location.svg',
        colorFilter: const ColorFilter.mode(
          AppColors.zonyPrimary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

void showCourierStopInfoSheet(BuildContext context, CourierStopModel stop) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return BottomSheetContainer(
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HederBottomSheetLine(),
              const SizedBox(height: 8),
              CourierStopCard(
                stop: stop,
                onTap: () => AppNavigator.pop(sheetContext),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}
