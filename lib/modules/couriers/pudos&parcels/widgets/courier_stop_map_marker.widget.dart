import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../models/courier_stop_model.dart';
import '../../../../services/helpers/open_in_maps_app.dart';
import '../../../../services/navigator.services/app_navigator.services.dart';
import '../../../../theme/app_colors.theme.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../views/widgets/bottom_sheet/componants_bottom_sheet.widgets.dart';
import '../../../../views/widgets/bottom_sheet_container.dart';
import '../../../../views/widgets/custom_outline_button.widget.dart';
import '../../../../views/widgets/toasts.dart';
import '../courier_stop_parcels.screen.dart';
import 'courier_stop_card.widget.dart';
import 'stops_map_view.widget.dart';

/// The stop's position, or null when it has no place/coordinates.
/// Missing lat/lng is parsed as 0 by CoordinatesModel, so 0 is treated as missing.
LatLng? _stopPosition(CourierStopModel stop) {
  final coordinates = stop.place?.coordinates;
  if (coordinates == null) return null;
  if (coordinates.latitude == 0 || coordinates.longitude == 0) return null;
  return LatLng(coordinates.latitude, coordinates.longitude);
}

/// Maps stops to map points, skipping stops without a valid position.
List<MapMarkerPoint<CourierStopModel>> courierStopsToMapPoints(
  List<CourierStopModel> stops,
) {
  final points = <MapMarkerPoint<CourierStopModel>>[];
  for (final stop in stops) {
    final position = _stopPosition(stop);
    if (position == null) continue;
    points.add(MapMarkerPoint(position: position, data: stop));
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
      final position = _stopPosition(stop);
      return BottomSheetContainer(
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HederBottomSheetLine(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CourierStopCard(
                      stop: stop,
                      onTap: () => AppNavigator.pop(sheetContext),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _OpenParcelsButton(
                    onTap: () => _openStopParcels(context, sheetContext, stop),
                  ),
                ],
              ),
              if (position != null) ...[
                const SizedBox(height: 16),
                _OpenInMapsButton(position: position, label: stop.place?.name),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
    },
  );
}

/// Closes the sheet, then pushes the stop's parcels from the map screen,
/// so going back returns to the map without the sheet.
void _openStopParcels(
  BuildContext mapContext,
  BuildContext sheetContext,
  CourierStopModel stop,
) {
  AppNavigator.pop(sheetContext);
  if (!mapContext.mounted) return;
  AppNavigator.navigateTo(
    mapContext,
    () => CourierStopParcelsScreen(stop: stop),
  );
}

class _OpenParcelsButton extends StatelessWidget {
  final VoidCallback onTap;

  const _OpenParcelsButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: S.of(context).viewParcels,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.zonyPrimaryTint,
        fixedSize: const Size.square(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: AppColors.zonyPrimary,
      ),
    );
  }
}

class _OpenInMapsButton extends StatelessWidget {
  final LatLng position;
  final String? label;

  const _OpenInMapsButton({required this.position, this.label});

  Future<void> _open(BuildContext context) async {
    final opened = await openInMapsApp(
      latitude: position.latitude,
      longitude: position.longitude,
      label: label,
    );
    if (!opened && context.mounted) {
      showErrorToast(message: S.of(context).couldNotOpenMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomOutlineButton(
      onTap: () => _open(context),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: AppColors.zonyPrimary,
          ),
          const SizedBox(width: 8),
          Text(S.of(context).location, style: AppTextStyles.textStyle16),
        ],
      ),
    );
  }
}
