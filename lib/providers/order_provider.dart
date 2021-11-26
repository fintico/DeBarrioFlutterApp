import 'package:debarrioapp/models/order_detail.dart';
import 'package:flutter/material.dart';

class OrderBloc extends ChangeNotifier {
  bool isGone = false;
  int rate = 0;
  int rateComment = 0;
  bool isDisable = true;

  OrderDetail? orderDetail;

  void onGone() {
    isGone = true;
    notifyListeners();
  }

  void isRated(int rated) {
    rate = rated;
    notifyListeners();
  }

  void onRatedComment(int ratedComment) {
    rateComment = ratedComment;
    notifyListeners();
  }

  void onDisable() {
    isDisable = false;
    notifyListeners();
  }

  void setOrder(OrderDetail orderTemp) {
    orderDetail = orderTemp;
    notifyListeners();
  }

  void removeAll() {
    //isGone = false;
    rate = 0;
    rateComment = 0;
    isDisable = true;
    notifyListeners();
  }
}
