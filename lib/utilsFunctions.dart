import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:debarrioapp/ModelClass/AdditionDishModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/utilProperties.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'ModelClass/orderList.dart';

bool cZeroStr(var input) {
  return input != null && input.length > 0;
}

/// This is called when the permission is accepted and we need to get user current position to show on map
void getCurrentLocation(Function setPosition) async {
  Geolocator.getCurrentPosition().then((Position position) async {
    setPosition(position);
    // notifyListeners();
  }).catchError((e) {
    print(e);
  });
}

OrderedDish getOrderedFromPosted(PostedDish postedDish) {
  return OrderedDish(
      id: Uuid().v4(),
      name: postedDish.name,
      dishPictureURI: postedDish.dishPictureURI,
      dishId: postedDish.id,
      makerId: postedDish.makerId,
      originalPrice: postedDish.originalPrice);
}

String getCurrentOrderListPrice(OrderList orderList) {
  double price = 0.0;
  if (cZeroStr(orderList.myOrders)) {
    for (OrderedDish dish in orderList.myOrders) {
      price += (double.parse(dish.originalPrice) * dish.quantity);
      price += getAdditionDishPriceForOrdered(dish);
    }
    if (orderList.order.tip != null) {
      price += double.parse(orderList.order.tip);
    }
    return price.toStringAsFixed(2);
  }
  return price.toStringAsFixed(2);
}

double getAdditionDishPriceForOrdered(OrderedDish dish) {
  double price = 0.0;
  for (AdditionDish addition in dish.additionDish) {
    if (addition.isSelected)
      price += (double.parse(addition.price) * dish.quantity);
  }
  return price;
}

double getAdditionDishPriceForPosted(PostedDish dish) {
  double price = 0.0;
  for (AdditionDish addition in dish.additionDish) {
    if (addition.isSelected) price += (double.parse(addition.price));
  }
  return price;
}

String calculatePriceForDish(OrderedDish myOrder) {
  double price = 0.00;
  price += myOrder.quantity * double.parse(myOrder.originalPrice);
  for (AdditionDish addition in myOrder.additionDish) {
    if (addition.isSelected)
      price += double.parse(addition.price) * myOrder.quantity;
  }
  return price.toStringAsFixed(2);
}

Future<void> getLocationPermission(Function setPosition) async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission != LocationPermission.always &&
      permission != LocationPermission.whileInUse) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse)
    getCurrentLocation(setPosition);
}

// get state dish (Active or Finish)
bool getDishState(DishModel dish) {
  bool isActive;
  DateTime today = DateTime.now().subtract(Duration(hours: 5));
  String dishFrom = dish.deliveryDate + ' ' + dish.deliveryTimeFrom;
  String dishTo = dish.deliveryDate + ' ' + dish.deliveryTimeTo;
  DateTime dateFrom = DateTime.parse(dishFrom);
  DateTime dateTo = DateTime.parse(dishTo);

  if (today.isAfter(dateFrom)) {
    //print('Finalizado');
    isActive = false;
  } else {
    //print('Activo');
    isActive = true;
  }

  return isActive;
}

String dateTimeString(DishModel dish) {
  String dateString;
  final formatter = new DateFormat('dd/MM/yyyy');
  String dishFrom = dish.deliveryDate + ' ' + dish.deliveryTimeFrom;
  String dishTo = dish.deliveryDate + ' ' + dish.deliveryTimeTo;
  DateTime dateFrom = DateTime.parse(dishFrom);
  DateTime dateTo = DateTime.parse(dishTo);
  String dishDate = formatter.format(dateFrom);
  //dayTime[dateFrom.hour];

  dateString = dishDate +
      ' ' +
      dayTime[dateFrom.hour] +
      ' ' +
      '-' +
      ' ' +
      dayTime[dateTo.hour];

  //print(dateString);
  return dateString;
}

//assets to bytes
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}
