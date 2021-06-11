import 'package:debarrioapp/models/customer_address.dart';

class Order {
  int id;
  bool isDelivery;
  bool isPickup;
  double totalPrice;
  int state;
  int portion;
  String deliveryDate;
  bool isActive;
  bool isDeleted;
  CustomerAddress customerAddress;

  Order({
    this.id,
    this.isDelivery,
    this.isPickup,
    this.totalPrice,
    this.state,
    this.portion,
    this.deliveryDate,
    this.isActive,
    this.isDeleted,
    this.customerAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      isDelivery: json['is_delivery'] as bool,
      isPickup: json['is_pickup'] as bool,
      totalPrice: json['total_price'] as double,
      state: json['state'] as int,
      portion: json['portion'] as int,
      deliveryDate: json['delivery_date'] as String,
      isActive: json['is_active'] as bool,
      isDeleted: json['is_deleted'] as bool,
      customerAddress: json['customer_address'] == null
          ? null
          : CustomerAddress.fromJson(
              json['customer_address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_delivery': isDelivery,
      'is_pickup': isPickup,
      'total_price': totalPrice,
      'state': state,
      'portion': portion,
      'delivery_date': deliveryDate,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'customer_address': customerAddress?.toJson(),
    };
  }
}
