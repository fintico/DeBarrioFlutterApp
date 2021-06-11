import 'package:debarrioapp/models/address.dart';

class SellerAddress {
  int id;
  int seller;
  Address address;
  bool isActive;

  SellerAddress({this.id, this.seller, this.address, this.isActive});

  factory SellerAddress.fromJson(Map<String, dynamic> json) {
    return SellerAddress(
      id: json['id'] as int,
      seller: json['seller'] as int,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller': seller,
      'address': address?.toJson(),
      'is_active': isActive,
    };
  }
}
