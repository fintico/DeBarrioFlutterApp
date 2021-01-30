import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da_brello_ui/ModelClass/AdditionDishModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderedDish extends ChangeNotifier {
  String id='';
  String name = '';
  String dishId = '';
  String orderId = '';
  String makerId = '';
  String buyerId = '';
  String totalService='';
  List<AdditionDish> additionDish;
  GeoPoint currentLocation;
  String dishPictureURI;
  int quantity;
  bool isDelivery;
  String status;
  String originalPrice;


  OrderedDish({
    this.name,
    this.id,
    this.dishId,
    this.makerId,
    this.buyerId,
    this.orderId,
    this.totalService,
    this.additionDish,
    this.currentLocation,
    this.dishPictureURI,
    this.status,
    this.isDelivery,
    this.originalPrice,
    this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'dishId': dishId,
      'makerId': makerId,
      'totalService': totalService,
      'buyerId': buyerId,
      'currentLocation': currentLocation,
      'dishPictureURI': dishPictureURI,
      'status': status,
      'isDelivery': isDelivery,
      'orderId': orderId,
      'originalPrice': originalPrice,
      'quantity': quantity,
      'additionDish': additionDish != null
          ? additionDish.map((AdditionDish addition) {
        return addition.toMap();
      }).toList()
          : new List(),
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.id = doc.data['id'] ?? '';
    this.name = doc.data['name'] ?? '';
    this.dishId = doc.data['dishId'];
    this.makerId = doc.data['makerId'];
    this.buyerId = doc.data['buyerId'];
    this.totalService = doc.data['totalService'];
    this.currentLocation = doc.data['currentLocation'];
    this.dishPictureURI = doc.data['dishPictureURI'];
    this.status = doc.data['status'];
    this.orderId = doc.data['orderId'];
    this.isDelivery = doc.data['isDelivery'];
    this.quantity = doc.data['quantity'];
    this.originalPrice = doc.data['originalPrice'];
    if (doc.data['dishAddition'] != null) {
      this.additionDish = new List();
      for (var value in doc.data['dishAddition']) {
        this.additionDish.add(AdditionDish.doc(value));
      }
    }
    this.notifyListeners();
  }
  OrderedDish.doc(value) {
    this.fromMap(value);
  }
}
