import 'dart:convert';

class InfoModel {
  final String first_name;
  final String last_name;
  final DateTime createdAt;
  final bool isAuthenticated;
  InfoModel({
    required this.first_name,
    required this.last_name,
    required this.createdAt,
    required this.isAuthenticated,
  });

  InfoModel copyWith({
    String? first_name,
    String? last_name,
    DateTime? createdAt,
    bool? isAuthenticated,
  }) {
    return InfoModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      createdAt: createdAt ?? this.createdAt,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isAuthenticated: map['isAuthenticated'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) =>
      InfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InfoModel(first_name: $first_name, last_name: $last_name, createdAt: $createdAt, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(covariant InfoModel other) {
    if (identical(this, other)) return true;

    return other.first_name == first_name &&
        other.last_name == last_name &&
        other.createdAt == createdAt &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return first_name.hashCode ^
        last_name.hashCode ^
        createdAt.hashCode ^
        isAuthenticated.hashCode;
  }
}
