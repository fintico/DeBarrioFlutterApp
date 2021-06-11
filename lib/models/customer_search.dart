import 'dishModel.dart';

class CustomerSearch {
  int id;
  DishModel dish;
  int customerId;

  CustomerSearch({
    this.id,
    this.dish,
    this.customerId,
  });

  factory CustomerSearch.fromJson(Map<String, dynamic> json) => CustomerSearch(
        id: json["id"] as int,
        dish: json['dish_search'] == null
            ? null
            : DishModel.fromJson(json['dish_search'] as Map<String, dynamic>),
        customerId: json["customer_search"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dish_search": dish?.toJson(),
        "customer_search": customerId,
      };
}
