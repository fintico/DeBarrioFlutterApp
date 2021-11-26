import 'dart:convert';

import 'package:debarrioapp/models/user.dart';

class Auth {
  Auth({
    this.status,
    this.data,
  });

  final String? status;
  final User? data;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
      };

  factory Auth.fromRawJson(String str) => Auth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
