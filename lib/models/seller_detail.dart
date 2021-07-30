import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_address.dart';

class SellerDetail {
  SellerDetail(
      {this.userId,
      this.restaurantName,
      this.urlImage,
      this.dishes,
      this.sellers});

  int userId;
  String restaurantName;
  dynamic urlImage;
  List<DishModel> dishes;
  List<SellerAddress> sellers;

  factory SellerDetail.fromJson(Map<String, dynamic> json) => SellerDetail(
        userId: json["user_id"],
        restaurantName:
            json["restaurant_name"] == null ? null : json["restaurant_name"],
        urlImage: json["urlImage"],
        dishes: json["dishes"] == null
            ? null
            : List<DishModel>.from(
                json["dishes"].map((dish) => DishModel.fromJson(dish))),
        sellers: json['sellers'] == null
            ? null
            : List<SellerAddress>.from(json["sellers"]
                .map((seller) => SellerAddress.fromJson(seller))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "restaurant_name": restaurantName,
        "urlImage": urlImage,
        "dishes": dishes == null
            ? null
            : List<DishModel>.from(dishes.map((dish) => dish.toJson())),
        "sellers": sellers == null
            ? null
            : List<SellerAddress>.from(
                sellers.map((seller) => seller.toJson())),
      };
}
