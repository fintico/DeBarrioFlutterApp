class LocationModel {
  int id;
  String addressName;
  String addressDescription;
  bool isActive;
  double longitude;
  double latitude;

  LocationModel({
    this.id,
    this.addressName,
    this.addressDescription,
    this.isActive,
    this.longitude,
    this.latitude,
  });

  @override
  String toString() {
    return 'LocationModel(id: $id, addressName: $addressName, addressDescription: $addressDescription, isActive: $isActive, longitude: $longitude, latitude: $latitude)';
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int,
      addressName: json['address_name'] as String,
      addressDescription: json['address_description'] ?? '-',
      isActive: json['is_active'] as bool,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_name': addressName,
      'address_description': addressDescription,
      'is_active': isActive,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
