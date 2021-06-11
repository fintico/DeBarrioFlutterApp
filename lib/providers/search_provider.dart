import 'package:flutter/material.dart';

class SearchBloc extends ChangeNotifier {
  String plate = 'null';

  void onChangePlate(String plateSearch) {
    plate = plateSearch;
    notifyListeners();
  }
}
