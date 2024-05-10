import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/position_model.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/model/location_model.dart';
import 'package:geolocator/geolocator.dart';

class SeaMapRepository {
  Future<PositionModel> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    var currentLocation = await Geolocator.getCurrentPosition();

    PositionModel positionModel = PositionModel(
        user_id: "",
        longitude: currentLocation.longitude,
        latitude: currentLocation.latitude,
        timestamp: DateTime.now(),
        accuracy: currentLocation.accuracy,
        altitude: currentLocation.altitude,
        heading: currentLocation.heading,
        speed: currentLocation.speed,
        speed_accuracy: currentLocation.speedAccuracy);

    return positionModel;
  }
}
