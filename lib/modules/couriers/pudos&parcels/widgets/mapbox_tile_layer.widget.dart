import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/mapbox.constants.dart';

/// Mapbox raster tiles. Swap this (and [MapboxAttribution]) to change tile provider.
TileLayer mapboxTileLayer() {
  return TileLayer(
    urlTemplate: MapboxConstants.tileUrlTemplate,
    tileDimension: 512,
    zoomOffset: -1,
    maxNativeZoom: 22,
    userAgentPackageName: 'com.zony.zony',
  );
}

/// Attribution required by the Mapbox ToS: wordmark always visible, text credits
/// in the expandable popup.
class MapboxAttribution extends StatelessWidget {
  const MapboxAttribution({super.key});

  void _open(String url) {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return RichAttributionWidget(
      showFlutterMapAttribution: false,
      attributions: [
        LogoSourceAttribution(
          SvgPicture.asset(MapboxConstants.logoAsset),
          height: 24,
          onTap: () => _open(MapboxConstants.aboutMapsUrl),
        ),
        TextSourceAttribution(
          'Mapbox',
          onTap: () => _open(MapboxConstants.aboutMapsUrl),
        ),
        TextSourceAttribution(
          'OpenStreetMap',
          onTap: () => _open(MapboxConstants.osmCopyrightUrl),
        ),
        TextSourceAttribution(
          'Improve this map',
          prependCopyright: false,
          onTap: () => _open(MapboxConstants.improveMapUrl),
        ),
      ],
    );
  }
}
