import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'mapbox_tile_layer.widget.dart';

/// A point to plot on [StopsMapView], carrying whatever item it represents.
class MapMarkerPoint<T> {
  final LatLng position;
  final T data;

  const MapMarkerPoint({required this.position, required this.data});
}

/// Renders N markers on one map and fits the camera to show them all.
/// Knows nothing about stops — a single-item list simply centers on that point.
/// [points] must not be empty (the camera fit needs at least one coordinate).
class StopsMapView<T> extends StatelessWidget {
  final List<MapMarkerPoint<T>> points;
  final Widget Function(BuildContext context, MapMarkerPoint<T> point) markerBuilder;
  final ValueChanged<MapMarkerPoint<T>>? onMarkerTap;
  final double markerSize;
  final double maxFitZoom;
  final Widget? tileLayer;
  final Widget? attribution;
  final MapController? mapController;

  const StopsMapView({
    super.key,
    required this.points,
    required this.markerBuilder,
    this.onMarkerTap,
    this.markerSize = 44,
    this.maxFitZoom = 16,
    this.tileLayer,
    this.attribution,
    this.mapController,
  });

  Marker _buildMarker(BuildContext context, MapMarkerPoint<T> point) {
    return Marker(
      point: point.position,
      width: markerSize,
      height: markerSize,
      child: GestureDetector(
        onTap: onMarkerTap == null ? null : () => onMarkerTap!(point),
        child: markerBuilder(context, point),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCameraFit: CameraFit.coordinates(
          coordinates: points.map((p) => p.position).toList(),
          padding: EdgeInsets.all(markerSize + 24),
          maxZoom: maxFitZoom,
        ),
        minZoom: 3,
        maxZoom: 19,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        tileLayer ?? mapboxTileLayer(),
        MarkerLayer(
          markers: points.map((p) => _buildMarker(context, p)).toList(),
        ),
        attribution ?? const MapboxAttribution(),
      ],
    );
  }
}
