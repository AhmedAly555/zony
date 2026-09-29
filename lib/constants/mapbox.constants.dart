class MapboxConstants {
  // Public (pk.*) token — restrict it by bundle/package id in the Mapbox dashboard.
  static const String accessToken = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

  static const String styleOwner = 'mapbox';
  static const String styleId = 'streets-v12';

  // 512px raster tiles (@2x) — pair with tileDimension 512 + zoomOffset -1.
  static const String tileUrlTemplate =
      'https://api.mapbox.com/styles/v1/$styleOwner/$styleId/tiles/512/{z}/{x}/{y}@2x?access_token=$accessToken';

  static const String logoAsset = 'assets/svgs/mapbox_logo.svg';

  static const String aboutMapsUrl = 'https://www.mapbox.com/about/maps/';
  static const String osmCopyrightUrl = 'https://www.openstreetmap.org/copyright';
  static const String improveMapUrl = 'https://apps.mapbox.com/feedback/';
}
