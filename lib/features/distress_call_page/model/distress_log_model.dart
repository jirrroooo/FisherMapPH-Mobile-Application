// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DistressLogModel {
  final String type;
  final String content;
  final String status;
  final DateTime createdAt;
  final double latitude;
  final double longitude;
  DistressLogModel({
    required this.type,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  DistressLogModel copyWith({
    String? type,
    String? content,
    String? status,
    DateTime? createdAt,
    double? latitude,
    double? longitude,
  }) {
    return DistressLogModel(
      type: type ?? this.type,
      content: content ?? this.content,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'content': content,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory DistressLogModel.fromMap(Map<String, dynamic> map) {
    return DistressLogModel(
      type: map['type'] as String,
      content: map['content'] as String,
      status: map['status'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistressLogModel.fromJson(String source) =>
      DistressLogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DistressLogModel(type: $type, content: $content, status: $status, createdAt: $createdAt, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant DistressLogModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.content == content &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        content.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
