// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AlertModel {
  final String description;
  final String level;
  final DateTime effective;
  final DateTime expires;
  final String instruction;
  final String title;
  final int radius;
  final List location;
  AlertModel({
    required this.description,
    required this.level,
    required this.effective,
    required this.expires,
    required this.instruction,
    required this.title,
    required this.radius,
    required this.location,
  });

  AlertModel copyWith({
    String? description,
    String? level,
    DateTime? effective,
    DateTime? expires,
    String? instruction,
    String? title,
    int? radius,
    List? location,
  }) {
    return AlertModel(
      description: description ?? this.description,
      level: level ?? this.level,
      effective: effective ?? this.effective,
      expires: expires ?? this.expires,
      instruction: instruction ?? this.instruction,
      title: title ?? this.title,
      radius: radius ?? this.radius,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'level': level,
      'effective': effective.millisecondsSinceEpoch,
      'expires': expires.millisecondsSinceEpoch,
      'instruction': instruction,
      'title': title,
      'radius': radius,
      'location': location,
    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
        description: map['description'] as String,
        level: map['level'] as String,
        effective: DateTime.fromMillisecondsSinceEpoch(map['effective'] as int),
        expires: DateTime.fromMillisecondsSinceEpoch(map['expires'] as int),
        instruction: map['instruction'] as String,
        title: map['title'] as String,
        radius: map['radius'] as int,
        location: List.from(
          (map['location'] as List),
        ));
  }

  String toJson() => json.encode(toMap());

  factory AlertModel.fromJson(String source) =>
      AlertModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlertModel(description: $description, level: $level, effective: $effective, expires: $expires, instruction: $instruction, title: $title, radius: $radius, location: $location)';
  }

  @override
  bool operator ==(covariant AlertModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.level == level &&
        other.effective == effective &&
        other.expires == expires &&
        other.instruction == instruction &&
        other.title == title &&
        other.radius == radius &&
        listEquals(other.location, location);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        level.hashCode ^
        effective.hashCode ^
        expires.hashCode ^
        instruction.hashCode ^
        title.hashCode ^
        radius.hashCode ^
        location.hashCode;
  }
}
