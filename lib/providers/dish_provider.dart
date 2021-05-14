import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishProvider extends ChangeNotifier {
  bool isLoading = true;

  DishModel _dishModel = new DishModel();
  List<DishModel> _list = [];

  /* DishProvider() {
    this._dishModel = _dishModel;
    this.list = list;
  } */

  DishModel get dish {
    return _dishModel;
  }

  void setList(List<DishModel> list) {
    _list = list;
    notifyListeners();
  }

  List<DishModel> get list {
    return _list;
  }

  set dish(DishModel dish) {
    _dishModel = dish;
    isLoading = false;
    notifyListeners();
  }
}
