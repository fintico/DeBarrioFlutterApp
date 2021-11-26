import 'dart:convert';

import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/models/seller_user.dart';

class SellerAddress {
  int? id;
  SellerUser? seller;
  Address? address;
  bool? isActive;

  SellerAddress({this.id, this.seller, this.address, this.isActive});

  factory SellerAddress.fromJson(Map<String, dynamic> json) {
    return SellerAddress(
      id: json['id'] as int,
      seller:
          json["seller"] == null ? null : SellerUser.fromJson(json["seller"]),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller': seller?.toJson(),
      'address': address?.toJson(),
      'is_active': isActive,
    };
  }

  factory SellerAddress.fromRawJson(String str) =>
      SellerAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
