import 'package:flutter/cupertino.dart';

class SaleBloc extends ChangeNotifier {
  bool isVisible = false;

  void onVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
