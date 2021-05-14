import 'package:flutter/cupertino.dart';
import 'package:debarrioapp/models/location_model.dart';

class LocationProvider extends ChangeNotifier {
  bool isLoading = true;

  List<LocationModel> _list = [];

  List<LocationModel> get list {
    return _list;
  }

  void location(List<LocationModel> list) {
    _list = list;
    notifyListeners();
  }
}
