import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:debarrioapp/ModelClass/AdditionDishModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/utilProperties.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:debarrioapp/constants/credit_card.dart' as CreditCard;
import 'package:path/path.dart' as path;

import 'ModelClass/orderList.dart';
import 'models/order.dart';

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

/* OrderedDish getOrderedFromPosted(PostedDish postedDish) {
  return OrderedDish(
      id: Uuid().v4(),
      name: postedDish.name,
      dishPictureURI: postedDish.dishPictureURI,
      dishId: postedDish.id,
      makerId: postedDish.makerId,
      originalPrice: postedDish.originalPrice);
} */

/* String getCurrentOrderListPrice(OrderList orderList) {
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
} */

/* double getAdditionDishPriceForOrdered(OrderedDish dish) {
  double price = 0.0;
  for (AdditionDish addition in dish.additionDish) {
    if (addition.isSelected)
      price += (double.parse(addition.price) * dish.quantity);
  }
  return price;
} */

/* double getAdditionDishPriceForPosted(PostedDish dish) {
  double price = 0.0;
  for (AdditionDish addition in dish.additionDish) {
    if (addition.isSelected) price += (double.parse(addition.price));
  }
  return price;
} */

/* String calculatePriceForDish(OrderedDish myOrder) {
  double price = 0.00;
  price += myOrder.quantity * double.parse(myOrder.originalPrice);
  for (AdditionDish addition in myOrder.additionDish) {
    if (addition.isSelected)
      price += double.parse(addition.price) * myOrder.quantity;
  }
  return price.toStringAsFixed(2);
} */
Future<String> uploadImage(File imageFile) async {
  String fileName = path.basename(imageFile.path);
  String urlImage;
  StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  taskSnapshot.ref.getDownloadURL().then(
    (value) {
      print("Done: $value");
      urlImage = value;
    },
  );
  return urlImage;
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
  //print(today);
  //print(dateFrom);
  if (today.isAfter(dateTo)) {
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

String dateSaleTimeString(DishModel dish, Order order) {
  String dateString;
  final formatter = new DateFormat('dd/MM/yyyy');
  String dishFrom = order.deliveryDate + ' ' + dish.deliveryTimeFrom;
  String dishTo = order.deliveryDate + ' ' + dish.deliveryTimeTo;
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

String dateOrderedTimeString(Order order) {
  String dateString;
  final formatter = new DateFormat('dd/MM/yyyy');
  String orderDate = order.deliveryDate +
      ' ' +
      (order.deliveryTime == null ? '00:00' : order.deliveryTime);

  DateTime dateFrom = DateTime.parse(orderDate);

  String date = formatter.format(dateFrom);
  if (order.deliveryTime == null) {
    dateString = date;
  } else {
    final orderTime = order.deliveryTime.split(':');
    final orderTimeE = dayTime[dateFrom.hour].split(' ');
    dateString =
        date + ' ' + orderTime[0] + ':' + orderTime[1] + ' ' + orderTimeE[1];
  }

  //final addressTemp = address.split(",");
  //String addressDish = '${addressTemp[0]}';

  return dateString;
}

String dateTimeDetail(DishModel dish) {
  String dateString;
  final formatter = new DateFormat('dd/MM/yyyy');
  String dishFrom = dish.deliveryDate + ' ' + dish.deliveryTimeFrom;
  DateTime dateFrom = DateTime.parse(dishFrom);
  String dishDate = formatter.format(dateFrom);

  dateString = dishDate;

  return dateString;
}

String orderDateDetail(OrderDetail orderDetail) {
  String dateString;
  final formatter = new DateFormat('dd/MM/yyyy');
  String orderFrom =
      orderDetail.order.deliveryDate + ' ' + orderDetail.dish.deliveryTimeFrom;
  DateTime dateFrom = DateTime.parse(orderFrom);
  String dishDate = formatter.format(dateFrom);

  dateString = dishDate;

  return dateString;
}

String timeFromDetail(DishModel dish) {
  String timeFromString;
  String dishFrom = dish.deliveryDate + ' ' + dish.deliveryTimeFrom;
  DateTime dateFrom = DateTime.parse(dishFrom);

  timeFromString = dayTime[dateFrom.hour];

  return timeFromString;
}

String timeToDetail(DishModel dish) {
  String timeToString;
  String dishTo = dish.deliveryDate + ' ' + dish.deliveryTimeTo;
  DateTime dateTo = DateTime.parse(dishTo);

  timeToString = dayTime[dateTo.hour];

  return timeToString;
}

String timeDetail(DishModel dish) {
  String dateString;
  String dishFrom = dish.deliveryDate + ' ' + dish.deliveryTimeFrom;
  String dishTo = dish.deliveryDate + ' ' + dish.deliveryTimeTo;
  DateTime dateFrom = DateTime.parse(dishFrom);
  DateTime dateTo = DateTime.parse(dishTo);
  //dayTime[dateFrom.hour];

  dateString = dayTime[dateFrom.hour] + ' ' + '-' + ' ' + dayTime[dateTo.hour];

  //print(dateString);
  return dateString;
}

String timeDetail24H(DishModel dish) {
  String dateString;

  final timeFromTemp = dish.deliveryTimeFrom.split(":");
  final timeToTemp = dish.deliveryTimeTo.split(":");
  String dishFrom = '${timeFromTemp[0]}:${timeFromTemp[1]}';
  String dishTo = '${timeToTemp[0]}:${timeToTemp[1]}';

  //dayTime[dateFrom.hour];

  dateString = dishFrom + ' ' + '-' + ' ' + dishTo + ' Hrs.';

  //print(dateString);
  return dateString;
}

String pluralPortion(int portionInt) {
  String portion;
  portion = portionInt > 1 ? 'Porciones' : 'Porción';
  //dayTime[dateFrom.hour];

  //print(dateString);
  return '0$portionInt $portion';
}

String toPluralOrderTitle(int lenght) {
  String order;
  order = lenght > 1 ? 'pedidos' : 'pedido';

  return '$lenght $order';
}

String toAddressShort(String address) {
  final addressTemp = address.split(",");
  String addressDish = '${addressTemp[0]}';

  return '$addressDish';
}

String toShortCreditCardNumber(String creditCardNumber) {
  String shortCreditCardNumber =
      creditCardNumber.substring(creditCardNumber.length - 5);

  return '$shortCreditCardNumber';
}

String convertUtcToLocal(String dateTemp) {
  final formatter = new DateFormat('dd/MM/yyyy HH:mm aaa');
  DateTime date = DateTime.parse(dateTemp).subtract(Duration(hours: 5));
  String dateFormatter = formatter.format(date);

  return '$dateFormatter';
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

CreditCard.CardType detectCCType(String cardNumber) {
  //Default card type is other
  CreditCard.CardType cardType = CreditCard.CardType.otherBrand;

  if (cardNumber.isEmpty) {
    return cardType;
  }

  cardNumPatterns.forEach(
    (CreditCard.CardType type, Set<List<String>> patterns) {
      for (List<String> patternRange in patterns) {
        // Remove any spaces
        String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        final int rangeLen = patternRange[0].length;
        // Trim the Credit Card number string to match the pattern prefix length
        if (rangeLen < cardNumber.length) {
          ccPatternStr = ccPatternStr.substring(0, rangeLen);
        }

        if (patternRange.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // Credit Card num is in the pattern range.
          // Because Strings don't have '>=' type operators
          final int ccPrefixAsInt = int.parse(ccPatternStr);
          final int startPatternPrefixAsInt = int.parse(patternRange[0]);
          final int endPatternPrefixAsInt = int.parse(patternRange[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt &&
              ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            cardType = type;
            break;
          }
        } else {
          // Just compare the single pattern prefix with the Credit Card prefix
          if (ccPatternStr == patternRange[0]) {
            // Found a match
            cardType = type;
            break;
          }
        }
      }
    },
  );
  return cardType;
}

Map<CreditCard.CardType, Set<List<String>>> cardNumPatterns =
    <CreditCard.CardType, Set<List<String>>>{
  CreditCard.CardType.visa: <List<String>>{
    <String>['4'],
  },
  CreditCard.CardType.americanExpress: <List<String>>{
    <String>['34'],
    <String>['37'],
  },
  CreditCard.CardType.discover: <List<String>>{
    <String>['6011'],
    <String>['622126', '622925'],
    <String>['644', '649'],
    <String>['65']
  },
  CreditCard.CardType.mastercard: <List<String>>{
    <String>['51', '55'],
    <String>['2221', '2229'],
    <String>['223', '229'],
    <String>['23', '26'],
    <String>['270', '271'],
    <String>['2720'],
  },
};
