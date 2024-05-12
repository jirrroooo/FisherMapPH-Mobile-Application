import 'dart:math';

import 'package:latlong2/latlong.dart';

class MapFunction {
  List<LatLng> computeCircleAlertBounds(
      double centerLng, double centerLat, double distance) {
    LatLng calculateDestination(double lon, double lat, double bearing) {
      final radius = 6371; // Earth radius in kilometers
      final lat1 = lat * (3.141592653589793 / 180);
      final lon1 = lon * (3.141592653589793 / 180);
      final angularDistance = distance / radius;
      final bearingRad = bearing * (3.141592653589793 / 180);

      var lat2 = asin(sin(lat1) * cos(angularDistance) +
          cos(lat1) * sin(angularDistance) * cos(bearingRad));
      var lon2 = lon1 +
          atan2(sin(bearingRad) * sin(angularDistance) * cos(lat1),
              cos(angularDistance) - sin(lat1) * sin(lat2));

      lat2 = lat2 * (180 / 3.141592653589793);
      lon2 = lon2 * (180 / 3.141592653589793);

      return LatLng(lat2, lon2);
    }

    List<LatLng> circumference = [];

    for (var i = 0; i < 360; i++) {
      if (i % 12 == 0) {
        circumference
            .add(calculateDestination(centerLng, centerLat, i.toDouble()));
      }
    }

    return circumference;
  }
}
