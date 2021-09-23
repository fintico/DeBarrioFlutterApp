import 'package:debarrioapp/models/customer_address.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBloc extends ChangeNotifier {
  int deliveryType = 0;
  int dishType = 0;
  int dishStyle = 0;
  int lifeStyle = 0;
  int day = 0;
  String deliveryDate;
  SellerAddress sellerAddress;
  CustomerAddress customerAddress;

  //location
  int addressId;

  List<SellerDish> sellers;
  List<SellerDetail> seller;

  void onDeliveryType(int type) {
    deliveryType = type;
    notifyListeners();
  }

  void onDishType(int type) {
    dishType = type;
    notifyListeners();
  }

  void onDishStyle(int type) {
    dishStyle = type;
    notifyListeners();
  }

  void onLifeStyle(int type) {
    lifeStyle = type;
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

  void onSetSellerDetail(List<SellerDetail> sellerTemp) {
    seller = sellerTemp;
    notifyListeners();
  }

  void onSetSellerAddress(SellerAddress sellerAddressTemp) {
    sellerAddress = sellerAddressTemp;
    notifyListeners();
  }

  void onSetCustomerAddress(CustomerAddress customerAddressTemp) {
    customerAddress = customerAddressTemp;
    notifyListeners();
  }

  void removeAll() {
    deliveryType = 0;
    dishType = 0;
    dishStyle = 0;
    lifeStyle = 0;
    day = 0;
    notifyListeners();
  }

  void onAddressId(int id) {
    addressId = id;
    notifyListeners();
  }

  void removeAddressId() {
    addressId = 0;
    notifyListeners();
  }
}
