import 'package:debarrioapp/Services/customer_service.dart';
import 'package:debarrioapp/Services/location_service.dart';
import 'package:debarrioapp/Services/seller_address_service.dart';
import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:debarrioapp/models/location_model.dart';
import 'package:sailor/sailor.dart';

class LocationProvider extends ChangeNotifier {
  String? _address;
  String? _addressDescription;
  double? _latitude;
  double? _longitude;

  bool isLoading = true;

  List<LocationModel> _list = [];

  List<LocationModel> get list {
    return _list;
  }

  String? get address => _address;
  String? get addressDescription => _addressDescription;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  set address(String? address) {
    _address = address;
    notifyListeners();
  }

  set addressDescription(String? addressDescription) {
    _addressDescription = addressDescription;
    notifyListeners();
  }

  set latitude(double? latitude) {
    _latitude = latitude;
    notifyListeners();
  }

  set longitude(double? longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  void location(List<LocationModel> list) {
    _list = list;
    notifyListeners();
  }

  void createUserLocation(
    String? address,
    String? addressDescription,
    double? latitude,
    double? longitude,
  ) async {
    final prefs = new UserPreferences();
    final LocationService instance =
        locationService.get(instanceName: 'LocationService');

    final SellerAddressService instanceSellerAddressService =
        sellerAddressService.get(instanceName: 'SellerAddressService');

    final CustomerService instanceCustomer =
        serviceCustomer.get(instanceName: 'CustomerService');

    final locationResponse = await Future.value(
      instance.postUserLocation(
        address!,
        addressDescription!,
        true,
        longitude!,
        latitude!,
      ),
    );

    Address addressModel = Address.fromRawJson(locationResponse.bodyBytes);

    prefs.address = addressModel.address!;
    prefs.latitude = addressModel.latitude!;
    prefs.longitude = addressModel.longitude!;

    await Future.wait([
      instanceSellerAddressService.postSellerAddress(
          prefs.userId, addressModel.id!, true),
      instanceCustomer.postCustomerAddress(
          prefs.userId, addressModel.id!, true),
    ]);

    Routes.sailor.navigate(
      Routes.HOME_SCREEN,
      navigationType: NavigationType.pushReplace,
      removeUntilPredicate: (route) => true,
    );

    notifyListeners();
  }
}
