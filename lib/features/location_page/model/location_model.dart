import 'dart:convert';

class LocationModel {
  final double longitude;
  final double latitude;
  final DateTime timestamp;
  final double sea_depth;
  LocationModel({
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.sea_depth,
  });

  LocationModel copyWith({
    double? longitude,
    double? latitude,
    DateTime? timestamp,
    double? sea_depth,
  }) {
    return LocationModel(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      timestamp: timestamp ?? this.timestamp,
      sea_depth: sea_depth ?? this.sea_depth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'longitude': longitude,
      'latitude': latitude,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'sea_depth': sea_depth,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      sea_depth: map['sea_depth'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(longitude: $longitude, latitude: $latitude, timestamp: $timestamp, sea_depth: $sea_depth)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.longitude == longitude &&
        other.latitude == latitude &&
        other.timestamp == timestamp &&
        other.sea_depth == sea_depth;
  }

  @override
  int get hashCode {
    return longitude.hashCode ^
        latitude.hashCode ^
        timestamp.hashCode ^
        sea_depth.hashCode;
  }
}
