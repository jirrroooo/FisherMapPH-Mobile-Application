import 'dart:convert';

class PositionModel {
  final String user_id;
  final double longitude;
  final double latitude;
  final DateTime timestamp;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  final double speed_accuracy;
  PositionModel({
    required this.user_id,
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.speed_accuracy,
  });

  PositionModel copyWith({
    String? user_id,
    double? longitude,
    double? latitude,
    DateTime? timestamp,
    double? accuracy,
    double? altitude,
    double? heading,
    double? speed,
    double? speed_accuracy,
  }) {
    return PositionModel(
      user_id: user_id ?? this.user_id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      timestamp: timestamp ?? this.timestamp,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      speed_accuracy: speed_accuracy ?? this.speed_accuracy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'longitude': longitude,
      'latitude': latitude,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'accuracy': accuracy,
      'altitude': altitude,
      'heading': heading,
      'speed': speed,
      'speed_accuracy': speed_accuracy,
    };
  }

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      user_id: map['user_id'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      accuracy: map['accuracy'] as double,
      altitude: map['altitude'] as double,
      heading: map['heading'] as double,
      speed: map['speed'] as double,
      speed_accuracy: map['speed_accuracy'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionModel.fromJson(String source) =>
      PositionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PositionModel(user_id: $user_id, longitude: $longitude, latitude: $latitude, timestamp: $timestamp, accuracy: $accuracy, altitude: $altitude, heading: $heading, speed: $speed, speed_accuracy: $speed_accuracy)';
  }

  @override
  bool operator ==(covariant PositionModel other) {
    if (identical(this, other)) return true;

    return other.user_id == user_id &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.timestamp == timestamp &&
        other.accuracy == accuracy &&
        other.altitude == altitude &&
        other.heading == heading &&
        other.speed == speed &&
        other.speed_accuracy == speed_accuracy;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        timestamp.hashCode ^
        accuracy.hashCode ^
        altitude.hashCode ^
        heading.hashCode ^
        speed.hashCode ^
        speed_accuracy.hashCode;
  }
}
