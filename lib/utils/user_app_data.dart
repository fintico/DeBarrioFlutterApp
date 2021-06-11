import 'package:debarrioapp/widgets/registration/registration_args.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class UserAppData {
  static final UserAppData _userAppData = new UserAppData._internal();

  String phoneNumber = '';
  String accessToken = '';
  String refreshToken = '';
  String verificationCode = '';
  String signCode = '';
  String address = '';
  String addressDescription = '';
  bool isActive = true;
  double latitude;
  double longitude;
  String dishName;

  //Placemark userCurrentLocation;
  RegistrationArgs registrationArgs =
      RegistrationArgs(phoneNumber: '', isReady: false, alreadyExist: false);

  UserAppData._internal();

  factory UserAppData() {
    return _userAppData;
  }

  @override
  String toString() {
    return 'UserAppData: {phoneNumber: $phoneNumber, address: $address, latitude: $latitude, longitude: $longitude}';
  }
}

final userAppData = UserAppData();
