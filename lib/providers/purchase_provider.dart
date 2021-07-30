import 'dart:collection';

import 'package:debarrioapp/models/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseBloc extends ChangeNotifier {
  int counter = 1;
  int orderId = 0;
  double totalPrice = 0.0;
  double totalPriceOrder = 0.0;
  double totalPriceOrderTemp = 0.0;
  double subTotalPrice;
  int portion;
  double priceDeliveryType;
  String addressDish = '-';
  int dishId;
  String restaurantName = '';
  String dishName = '';
  String dateTime = '';
  String dishImage = '';
  int tip = 0;
  bool delivery;
  bool pickup;
  bool isCreated = false;

  //
  List<OrderDetail> _orderDetail = [];
  //double priceTotal = 0.0;

  //modal date
  int day = 0;
  String deliveryDate;
  String shortDate;

  UnmodifiableListView<OrderDetail> get orderDetails =>
      UnmodifiableListView(_orderDetail);

  void addOrder(OrderDetail orderDetail) {
    //totalPriceTemp += subTotalPrice;

    totalPriceOrder += totalPrice;
    print(totalPriceOrder);
    totalPriceOrderTemp = totalPriceOrder;
    print(totalPriceOrderTemp);
    //totalPrice = totalPriceTemp;
    _orderDetail.add(orderDetail);

    notifyListeners();
  }

  void removeOrder(int index) {
    totalPrice = 0.0;
    totalPriceOrder -= _orderDetail[index].order.totalPrice;
    totalPriceOrderTemp -= _orderDetail[index].order.totalPrice;

    print(totalPriceOrder);
    print(totalPriceOrderTemp);
    print(totalPrice);
    _orderDetail.removeAt(index);
    notifyListeners();
  }

  void removeAllOrder() {
    //_orderDetail.clear();
    totalPriceOrder = 0.0;
    totalPriceOrderTemp = 0.0;
    totalPrice = 0.0;
    notifyListeners();
  }

  void onAddItem(int index) {
    _orderDetail[index].order.portion++;
    orderDetails[index].order.totalPrice +=
        orderDetails[index].order.subtotalPrice;
    totalPriceOrder += _orderDetail[index].order.subtotalPrice;
    totalPriceOrderTemp = totalPriceOrder;

    notifyListeners();
  }

  void onSubtractItem(int index) {
    if (_orderDetail[index].order.portion <= 1) {
      _orderDetail[index].order.portion = 1;
    } else {
      _orderDetail[index].order.portion--;
      orderDetails[index].order.totalPrice -=
          orderDetails[index].order.subtotalPrice;
      totalPriceOrder -= _orderDetail[index].order.subtotalPrice;
      totalPriceOrderTemp = totalPriceOrder;
    }
    notifyListeners();
  }

  void onCount() {
    counter++;
    notifyListeners();
  }

  void onSubtract() {
    if (counter <= 1) {
      counter = 1;
    } else {
      counter--;
    }
    notifyListeners();
  }

  void onPriceDeliveryType(double priceTemp) {
    priceDeliveryType = priceTemp;
    notifyListeners();
  }

  void onTip(int tipTemp) {
    tip = tipTemp;

    print(totalPriceOrderTemp);
    print(tip);

    totalPriceOrder = totalPriceOrderTemp + tip;
    notifyListeners();
  }

  void onDishImage(String image) {
    dishImage = image;
    notifyListeners();
  }

  void onSubTotalPrice(double price) {
    subTotalPrice = price;
    notifyListeners();
  }

  void onTotalPrice(double price) {
    subTotalPrice = price;
    totalPrice = double.parse((price * counter).toStringAsFixed(2));
    notifyListeners();
  }

  void onAddress(String address) {
    final addressTemp = address.split(",");
    addressDish = '${addressTemp[0]}';
    notifyListeners();
  }

  void onNotify() {
    isCreated = true;
    notifyListeners();
  }

  void onNotifyDisable() {
    isCreated = false;
    notifyListeners();
  }

  void onDishId(int id) {
    dishId = id;
    notifyListeners();
  }

  void onDishName(String name) {
    dishName = name;
    notifyListeners();
  }

  void onDishDate(String date) {
    dateTime = date;
    notifyListeners();
  }

  void onDelivery() {
    delivery = true;
    pickup = false;
    notifyListeners();
  }

  void onPickup() {
    pickup = true;
    delivery = false;
    notifyListeners();
  }

  void onOrder(int id) {
    orderId = id;
    notifyListeners();
  }

  void onRestaurant(String restaurantNameTemp) {
    restaurantName = restaurantNameTemp;
    notifyListeners();
  }

  void onDayTime(int dayType) {
    DateTime today = DateTime.now().subtract(Duration(hours: 5));
    final formatterTo = new DateFormat('yyyy-MM-dd');
    DateTime time = today.add(Duration(days: dayType));
    deliveryDate = formatterTo.format(time);
    day = dayType;
    notifyListeners();
  }

  void onSetDateTime(int dayType) {
    DateTime today = DateTime.now().subtract(Duration(hours: 5));
    final formatter = new DateFormat('dd/MM');
    DateTime time = today.add(Duration(days: dayType));
    shortDate = formatter.format(time);
    print(shortDate);

    //day = dayType;
    notifyListeners();
  }
}
