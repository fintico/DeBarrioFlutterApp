import 'dart:developer';

import 'package:debarrioapp/Services/customer_service.dart';
import 'package:debarrioapp/Services/register_service.dart';
import 'package:debarrioapp/Services/seller_service.dart';
import 'package:debarrioapp/models/auth.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  String? _code;
  String? _phoneNumber;
  String? _uid;

  String? get code => _code;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;

  set code(String? code) {
    _code = code;
    notifyListeners();
  }

  set phoneNumber(String? phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  set uid(String? uid) {
    _uid = uid;
    notifyListeners();
  }

  void loginUser(String? uid) async {
    final RegisterService instance =
        serviceLogin.get(instanceName: 'RegisterService');

    final response = await Future.value(instance.patchUser(88, uid!));

    inspect(response);

    notifyListeners();
  }

  void createUser(String? code, String? phonenumber, String? uid) async {
    final prefs = new UserPreferences();

    final RegisterService instance =
        serviceLogin.get(instanceName: 'RegisterService');
    final SellerService instanceService =
        serviceSeller.get(instanceName: 'SellerService');

    final CustomerService instanceCustomer =
        serviceCustomer.get(instanceName: 'CustomerService');

    final userResponse = await Future.value(
      instance.postUserRegister(code!, phonenumber!),
    );

    Auth auth = Auth.fromRawJson(userResponse.bodyString);

    await Future.wait([
      instance.patchUser(auth.data!.id!, uid!),
      instanceService.postSeller(auth.data!.id!),
      instanceCustomer.postCustomer(auth.data!.id!),
    ]);

    prefs.username = auth.data!.username!;
    prefs.userId = auth.data!.id!;

    notifyListeners();
  }
}
