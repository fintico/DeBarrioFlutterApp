import 'package:debarrioapp/models/credit_card.dart';
import 'package:debarrioapp/models/customer_address.dart';

class Order {
  int id;
  bool isDelivery;
  bool isPickup;
  double totalPrice;
  double subtotalPrice;
  double tip;
  int state;
  int portion;
  String deliveryDate;
  String deliveryTime;
  bool isActive;
  bool isDeleted;
  String createdAt;
  CustomerAddress customerAddress;
  CreditCard creditCard;

  Order({
    this.id,
    this.isDelivery,
    this.isPickup,
    this.totalPrice,
    this.subtotalPrice,
    this.tip,
    this.state,
    this.portion,
    this.deliveryDate,
    this.deliveryTime,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.customerAddress,
    this.creditCard,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      isDelivery: json['is_delivery'] as bool,
      isPickup: json['is_pickup'] as bool,
      totalPrice: json['total_price'] as double,
      subtotalPrice: json['subtotal_price'] as double,
      tip: json['tip'] as double,
      state: json['state'] as int,
      portion: json['portion'] as int,
      deliveryDate: json['delivery_date'] as String,
      deliveryTime: json['delivery_time'] as String,
      isActive: json['is_active'] as bool,
      isDeleted: json['is_deleted'] as bool,
      createdAt: json['created_at'] as String,
      customerAddress: json['customer_address'] == null
          ? null
          : CustomerAddress.fromJson(
              json['customer_address'] as Map<String, dynamic>),
      creditCard: json['credit_card'] == null
          ? null
          : CreditCard.fromJson(json['credit_card'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_delivery': isDelivery,
      'is_pickup': isPickup,
      'total_price': totalPrice,
      'subtotal_price': subtotalPrice,
      'tip': tip,
      'state': state,
      'portion': portion,
      'delivery_date': deliveryDate,
      'delivery_time': deliveryTime,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'customer_address': customerAddress?.toJson(),
      'credit_card': creditCard?.toJson(),
    };
  }
}
