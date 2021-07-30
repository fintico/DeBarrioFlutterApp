import 'dart:convert';

class Address {
  int id;
  String address;
  String addressDescription;
  bool isActive;
  double longitude;
  double latitude;

  Address({
    this.id,
    this.address,
    this.addressDescription,
    this.isActive,
    this.longitude,
    this.latitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      address: json['address_name'] as String,
      addressDescription: json['address_description'] as String,
      isActive: json['is_active'] as bool,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_name': address,
      'address_description': addressDescription,
      'is_active': isActive,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
