import 'package:debarrioapp/models/user.dart';

class Customer {
  User user;

  Customer({this.user});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
    };
  }
}
