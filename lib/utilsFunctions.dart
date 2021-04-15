import 'package:debarrioapp/ModelClass/AdditionDishModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:geolocator/geolocator.dart';
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
