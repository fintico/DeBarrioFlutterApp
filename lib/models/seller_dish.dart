import 'package:debarrioapp/models/dishModel.dart';

class SellerDish {
  SellerDish({
    this.userId,
    this.restaurantName,
    this.urlImage,
    this.dishes,
  });

  int? userId;
  String? restaurantName;
  dynamic urlImage;
  List<DishModel>? dishes;

  factory SellerDish.fromJson(Map<String, dynamic> json) => SellerDish(
        userId: json["user_id"],
        restaurantName:
            json["restaurant_name"] == null ? null : json["restaurant_name"],
        urlImage: json["urlImage"],
        dishes: json["dishes"] == null
            ? null
            : List<DishModel>.from(
                json["dishes"].map((dish) => DishModel.fromJson(dish))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "restaurant_name": restaurantName,
        "urlImage": urlImage,
        "dishes": dishes == null
            ? null
            : List<DishModel>.from(dishes!.map((dish) => dish.toJson())),
      };
}
