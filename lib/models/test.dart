import 'additional.dart';
import 'dish_category.dart';

class Test {
  int id;
  Additional additional;
  DishCategory dishCategory;
  String dishName;
  String image;
  int stock;
  String deliveryDate;
  String deliveryTimeFrom;
  String deliveryTimeTo;
  double priceDelivery;
  double pricePickup;
  bool isActive;
  bool isDeleted;
  String createdAt;
  String updatedAt;
  int seller;

  Test({
    this.id,
    this.additional,
    this.dishCategory,
    this.dishName,
    this.image,
    this.stock,
    this.deliveryDate,
    this.deliveryTimeFrom,
    this.deliveryTimeTo,
    this.priceDelivery,
    this.pricePickup,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.seller,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'] as int,
      additional: json['additional'] == null
          ? null
          : Additional.fromJson(json['additional'] as Map<String, dynamic>),
      dishCategory: json['dish_category'] == null
          ? null
          : DishCategory.fromJson(
              json['dish_category'] as Map<String, dynamic>),
      dishName: json['dish_name'] as String,
      image: json['image'] as String,
      stock: json['stock'] as int,
      deliveryDate: json['delivery_date'] as String,
      deliveryTimeFrom: json['delivery_time_from'] as String,
      deliveryTimeTo: json['delivery_time_to'] as String,
      priceDelivery: json['price_delivery'] as double,
      pricePickup: json['price_pickup'] as double,
      isActive: json['is_active'] as bool,
      isDeleted: json['is_deleted'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      seller: json['seller'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'additional': additional?.toJson(),
      'dish_category': dishCategory?.toJson(),
      'dish_name': dishName,
      'image': image,
      'stock': stock,
      'delivery_date': deliveryDate,
      'delivery_time_from': deliveryTimeFrom,
      'delivery_time_to': deliveryTimeTo,
      'price_delivery': priceDelivery,
      'price_pickup': pricePickup,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'seller': seller,
    };
  }
}
