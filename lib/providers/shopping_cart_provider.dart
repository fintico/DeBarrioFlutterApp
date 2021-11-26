import 'package:flutter/material.dart';

class ShoppingCartBloc extends ChangeNotifier {
  int? tiped;

  void onTiped(int tip) {
    tiped = tip;
    notifyListeners();
  }
}
