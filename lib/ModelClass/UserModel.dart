import'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da_brello_ui/ModelClass/AddressModel.dart';
import 'package:da_brello_ui/ModelClass/BankCardModel.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _id = '';
  String _phoneNumber = '';
  List<BankCard> _cards = new List<BankCard>();
  List<InAppAddress> _address = new List<InAppAddress>();
  String _fcmDeviceCode = '';
  String _pictureUri = '';
  String _restaurantName = '';
  String _reviews = '';
  int _distance;


  int get distance => _distance;

  set distance(int value) {
    _distance = value;
  }

  String get reviews => _reviews;

  set reviews(String value) {
    _reviews = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get restaurantName => _restaurantName;

  set restaurantName(String value) {
    _restaurantName = value;
  }

  User.fromData(String id) {
    this.id = id;
  }
  User();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'cards': cards != null
          ? cards.map((BankCard bankCard) {
        return bankCard.toMap();
      }).toList()
          : new List(),
      'address': _address != null
          ? _address.map((InAppAddress _address) {
        return _address.toMap();
      }).toList()
          : new List(),
      'fcmDeviceCode': fcmDeviceCode,
      'pictureUri': pictureUri,
      'restaurantName': restaurantName,
      'reviews': reviews,
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.name = doc.data['name'] ;
    this.id = doc.data['id'];
    this.email = doc.data['email'];
    this.phoneNumber = doc.data['phoneNumber'];
    this.fcmDeviceCode = doc.data['fcmDeviceCode'] ?? '';
    this.restaurantName = doc.data['restaurantName'] ?? '';
    this.pictureUri = doc.data['pictureUri'] ?? '';
    this.reviews = doc.data['reviews'] ?? '';
    if (doc.data['cards'] != null) {
      this.cards = new List();
      for (var value in doc.data['cards']) {
        this.cards.add(BankCard.doc(value));
      }
    } if (doc.data['address'] != null) {
      this._address = new List();
      for (var value in doc.data['address']) {
        this._address.add(InAppAddress.doc(value));
      }
    }
    this.notifyListeners();
  }

  void fromUser(User user, {bool isListen:true}) {
    this.name = user.name;
    this.id = user.id;
    this.email = user.email;
    this.phoneNumber = user.phoneNumber;
    this.reviews = user.reviews;
    this.distance = user.distance;
    this.fcmDeviceCode = user.fcmDeviceCode;
    this.restaurantName = user.restaurantName;
    this.pictureUri = user.pictureUri;
    this._address = user._address;
    this.cards = user.cards;
    if(isListen)
      this.notifyListeners();
  }



  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  List<BankCard> get cards => _cards;

  set cards(List<BankCard> value) {
    _cards = value;
  }


  String get fcmDeviceCode => _fcmDeviceCode;

  set fcmDeviceCode(String value) {
    _fcmDeviceCode = value;
  }
  String get pictureUri => _pictureUri;

  set pictureUri(String value) {
    _pictureUri = value;
  }


  List<InAppAddress> get address => _address;

  set address(List<InAppAddress> value) {
    _address = value;
  }

  void updateNameAndPicture(String name, String pictureUri) {
    this.name = name;
    this.pictureUri = pictureUri;
    notifyListeners();
  }
  void updateName(String name) {
    this.name = name;
    notifyListeners();
  }
  void updatePicture(String pictureUri) {
    this.pictureUri = pictureUri;
    notifyListeners();
  }


}
