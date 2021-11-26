import 'package:debarrioapp/models/order.dart';
import 'package:debarrioapp/models/dishModel.dart';

class OrderDetail {
  int? id;
  DishModel? dish;
  Order? order;

  OrderDetail({
    this.id,
    this.dish,
    this.order,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] as int,
      dish: json['dish'] == null
          ? null
          : DishModel.fromJson(json['dish'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': dish?.toJson(),
      'order': order?.toJson(),
    };
  }
}
