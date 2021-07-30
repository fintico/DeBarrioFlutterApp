/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Order extends ChangeNotifier {
  String id = '';
  String buyerId = '';
  DateTime salesDate;
  GeoPoint orderDeliverLocation;
  String status;
  String originalPrice;
  String tip;
  String dishName;
  String dishPictureURL;
  int noOfDishes;

  Order({
    this.id,
    this.buyerId,
    this.salesDate,
    this.orderDeliverLocation,
    this.status,
    this.originalPrice,
    this.tip,
    this.dishName,
    this.noOfDishes,
    this.dishPictureURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'salesDate': salesDate,
      'orderDeliverLocation': orderDeliverLocation,
      'status': status,
      'originalPrice': originalPrice,
      'tip': tip,
      'dishName': dishName,
      'noOfDishes': noOfDishes,
      'dishPictureURL': dishPictureURL,
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.id = doc.data['id'];
    this.buyerId = doc.data['buyerId'];
    this.salesDate = doc.data['salesDate'].toDate();
    this.orderDeliverLocation = doc.data['orderDeliverLocation'];
    this.status = doc.data['status'];
    this.originalPrice = doc.data['originalPrice'];
    this.tip = doc.data['tip'];
    this.dishName = doc.data['dishName'];
    this.noOfDishes = doc.data['noOfDishes'];
    this.dishPictureURL = doc.data['dishPictureURL'];
    this.notifyListeners();
  }
}
 */
