import 'package:flutter/material.dart';

import '../../../models/courier_stop_model.dart';
import '../../../views/widgets/default_appbar.dart';
import '../../../views/widgets/no_data_found.widget.dart';
import '../../../views/widgets/template_app_scaffold.widget.dart';
import 'widgets/courier_stop_map_marker.widget.dart';
import 'widgets/stops_map_view.widget.dart';

/// Shows already-loaded courier stops (any direction) as markers on one map.
class CourierStopsMapScreen extends StatefulWidget {
  final List<CourierStopModel> stops;
  final String title;

  const CourierStopsMapScreen({
    super.key,
    required this.stops,
    required this.title,
  });

  @override
  State<CourierStopsMapScreen> createState() => _CourierStopsMapScreenState();
}

class _CourierStopsMapScreenState extends State<CourierStopsMapScreen> {
  late List<MapMarkerPoint<CourierStopModel>> _points;

  @override
  void initState() {
    super.initState();
    _points = courierStopsToMapPoints(widget.stops);
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            AppBarHaveArrow(title: widget.title),
            const SizedBox(height: 24),
            Expanded(child: _buildMap()),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    if (_points.isEmpty) {
      return const Center(child: NoDataFoundWidget());
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: StopsMapView<CourierStopModel>(
        points: _points,
        markerBuilder: (context, point) => const CourierStopMapMarker(),
        onMarkerTap: (point) => showCourierStopInfoSheet(context, point.data),
      ),
    );
  }
}
