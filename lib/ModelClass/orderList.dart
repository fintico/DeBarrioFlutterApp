

import 'package:da_brello_ui/ModelClass/OrderedDish.dart';
import 'package:flutter/cupertino.dart';

import 'OrderModel.dart';

class OrderList extends ChangeNotifier {
  List<OrderedDish> myOrders=[];
  Order order=Order();
  OrderList({
    this.order,
    this.myOrders,
  });
}
