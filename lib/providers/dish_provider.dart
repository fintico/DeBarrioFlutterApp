import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isActive = false;

  DishModel _dishModel = new DishModel();
  List<DishModel> _list = [];

  /* DishProvider() {
    this._dishModel = _dishModel;
    this.list = list;
  } */

  DishModel get dish {
    return _dishModel;
  }

  set dish(DishModel dish) {
    _dishModel = dish;
    isLoading = false;
    notifyListeners();
  }

  void setList(List<DishModel> list) {
    _list = list;
    isLoading = true;
    notifyListeners();
  }

  List<DishModel> get list {
    return _list;
  }

  void onActive(bool isActive) {
    isActive = isActive;
    notifyListeners();
  }

  void loadPosts() async {
    /* final DishService instanceDish =
        dishService.get(instanceName: 'DishService'); */

    DishService dishService = DishService.create();

    final response = await Future.value(dishService.getDishList());
    List<DishModel> dishList = (json.decode(response.bodyString) as List)
        .map((e) => DishModel.fromJson(e))
        .toList();
    setList(dishList);

    inspect(dishList);

    notifyListeners();
  }
}
