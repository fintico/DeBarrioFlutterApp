import 'package:debarrioapp/models/rating.dart';

class Seller {
  int? id;
  Rating? rating;
  String? restaurantName;
  String? urlImage;

  Seller({
    this.id,
    this.rating,
    this.restaurantName,
    this.urlImage,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['user'] as int,
      rating: json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      restaurantName: json['restaurant_name'] as String,
      urlImage: json['urlImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': id,
      'rating': rating?.toJson(),
      'restaurant_name': restaurantName,
      'urlImage': urlImage,
    };
  }
}
