import 'package:flutter/material.dart';

class ProfileBloc extends ChangeNotifier {
  String _restaurantName;
  String _fullName;
  String _email;
  bool isGone = false;
  bool isUpdated = false;

  /* void onRestaurantName(String restaurantNameTemp) {
    restaurantName = restaurantNameTemp;
    notifyListeners();
  } */

  void onGone() {
    isGone = true;
    notifyListeners();
  }

  void onUpdated() {
    isUpdated = true;
    notifyListeners();
  }

  void removeAll() {
    _restaurantName = null;
    _fullName = null;
    _email = null;
    notifyListeners();
  }

  void removeAllNotify() {
    isGone = false;
    isUpdated = false;
    notifyListeners();
  }

  get restaurantName {
    return _restaurantName;
  }

  set restaurantName(String name) {
    _restaurantName = name;
    notifyListeners();
  }

  get fullName {
    return _fullName;
  }

  set fullName(String name) {
    _fullName = name;
    notifyListeners();
  }

  get email {
    return _email;
  }

  set email(String name) {
    _email = name;
    notifyListeners();
  }
}
