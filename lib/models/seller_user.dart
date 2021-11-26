import 'dart:io';

import 'package:debarrioapp/models/user.dart';

class SellerUser {
  User? user;
  String? restaurantName;
  String? urlImage;

  SellerUser({this.user, this.restaurantName, this.urlImage});

  factory SellerUser.fromJson(Map<String, dynamic> json) => SellerUser(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        restaurantName: json['restaurant_name'] as String,
        urlImage: json['urlImage'] as String,
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        'restaurant_name': restaurantName,
        'urlImage': urlImage,
      };
}
