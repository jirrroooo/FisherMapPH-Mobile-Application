import 'package:latlong2/latlong.dart';

class BoundaryModel {
  final String title;
  final String region;
  final String province;
  final String municipality;
  final int postal_code;
  final List<LatLng> location;

  BoundaryModel(
      {required this.title,
      required this.region,
      required this.province,
      required this.municipality,
      required this.postal_code,
      required this.location});
}
