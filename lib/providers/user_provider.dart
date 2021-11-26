import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _phoneNumber;

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
    notifyListeners();
  }
}
