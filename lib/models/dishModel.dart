class DishModel {
  int id;
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
  int dishCategory;
  int additional;

  DishModel({
    this.id,
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
    this.dishCategory,
    this.additional,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'] as int,
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
      dishCategory: json['dish_category'] as int,
      additional: json['additional'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'dish_category': dishCategory,
      'additional': additional,
    };
  }
}
