import 'dart:convert';

class ContactModel {
  final String name;
  final String email_address;
  final String contact_number;
  final String address;
  ContactModel({
    required this.name,
    required this.email_address,
    required this.contact_number,
    required this.address,
  });

  ContactModel copyWith({
    String? name,
    String? email_address,
    String? contact_number,
    String? address,
  }) {
    return ContactModel(
      name: name ?? this.name,
      email_address: email_address ?? this.email_address,
      contact_number: contact_number ?? this.contact_number,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email_address': email_address,
      'contact_number': contact_number,
      'address': address,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      name: map['name'] as String,
      email_address: map['email_address'] as String,
      contact_number: map['contact_number'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactModel(name: $name, email_address: $email_address, contact_number: $contact_number, address: $address)';
  }

  @override
  bool operator ==(covariant ContactModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email_address == email_address &&
        other.contact_number == contact_number &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email_address.hashCode ^
        contact_number.hashCode ^
        address.hashCode;
  }
}
