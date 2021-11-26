import 'dart:convert';
import 'dart:developer';

import 'package:debarrioapp/Services/customer_service.dart';
import 'package:debarrioapp/Services/dish_service.dart';
import 'package:debarrioapp/Services/seller_address_service.dart';
import 'package:debarrioapp/Services/seller_service.dart';
import 'package:debarrioapp/models/customer_address.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBloc extends ChangeNotifier {
  int deliveryType = 0;
  int dishType = 0;
  int dishStyle = 0;
  int lifeStyle = 0;
  int day = 0;
  String? deliveryDate;
  SellerAddress? _sellerAddress;
  CustomerAddress? _customerAddress;

  //location
  int? addressId;

  List<SellerDish>? sellers;
  List<SellerDetail>? seller;

  SellerAddress? get sellerAddress => _sellerAddress;

  set sellerAddress(SellerAddress? sellerAddress) {
    this._sellerAddress = sellerAddress;
    notifyListeners();
  }

  CustomerAddress? get customerAddress => _customerAddress;

  set customerAddress(CustomerAddress? customerAddress) {
    this._customerAddress = customerAddress;
    notifyListeners();
  }

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

  void loadRestaurants() async {
    /* final SellerService instanceService =
        serviceSeller.get(instanceName: 'SellerService'); */

    SellerService sellerService = SellerService.create();

    final response = await Future.value(sellerService.getDishesBySeller());

    List<SellerDetail> seller = (json.decode(response.bodyString) as List)
        .map((e) => SellerDetail.fromJson(e))
        .toList();

    inspect(seller);
    onSetSellerDetail(seller);

    notifyListeners();
  }

  void loadUser() async {
    final prefs = UserPreferences();
    /* final CustomerService instanceCustomer =
        serviceCustomer.get(instanceName: 'CustomerService'); */
    print(prefs.userId);
    CustomerService customerService = CustomerService.create();
    SellerAddressService sellerAddressService = SellerAddressService.create();

    /* final SellerAddressService instanceSellerAddressService =
        sellerAddressService.get(instanceName: 'SellerAddressService'); */

    final response = await Future.wait(
      [
        sellerAddressService.getSellerDetail(prefs.userId),
        customerService.getCustomerDetail(prefs.userId),
      ],
    );

    /*  inspect(response[0]);
    inspect(response[1]); */

    _sellerAddress = SellerAddress.fromRawJson(response[0].bodyString);
    _customerAddress = CustomerAddress.fromRawJson(response[1].bodyString);

    notifyListeners();
  }
}
