/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debarrioapp/ModelClass/AdditionDishModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostedDish extends ChangeNotifier {
  String name = '';
  String id = '';
  String makerId = '';
  String salesNumber = '';
  String totalService = '';
  String category = '';
  DateTime salesDate;
  DateTime startTime;
  DateTime endTime;
  List<AdditionDish> additionDish;
  GeoPoint currentLocation;
  String dishPictureURI;
  String status;
  String originalPrice;
  String priceWithDelivery;

  //Not to be uploaded
  String addressString;

  PostedDish(
      {this.name,
      this.id,
      this.makerId,
      this.salesNumber,
      this.totalService,
      this.category,
      this.salesDate,
      this.startTime,
      this.endTime,
      this.additionDish,
      this.currentLocation,
      this.dishPictureURI,
      this.status,
      this.originalPrice,
      this.priceWithDelivery});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'makerId': makerId,
      'id': id,
      'salesNumber': salesNumber,
      'totalService': totalService,
      'category': category,
      'salesDate': salesDate,
      'startTime': startTime,
      'endTime': endTime,
      'currentLocation': currentLocation,
      'dishPictureURI': dishPictureURI,
      'status': status,
      'originalPrice': originalPrice,
      'priceWithDelivery': priceWithDelivery,
      'additionDish': additionDish != null
          ? additionDish.map((AdditionDish addition) {
              return addition.toMap();
            }).toList()
          : new List(),
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.name = doc.data['name'] ?? '';
    this.id = doc.data['id'];
    this.makerId = doc.data['makerId'];
    this.salesNumber = doc.data['salesNumber'];
    this.totalService = doc.data['totalService'];
    this.category = doc.data['category'];
    this.salesDate = doc.data['salesDate'].toDate();
    this.startTime = doc.data['startTime'].toDate();
    this.endTime = doc.data['endTime'].toDate();
    this.currentLocation = doc.data['currentLocation'];
    this.dishPictureURI = doc.data['dishPictureURI'];
    this.status = doc.data['status'];
    this.originalPrice = doc.data['originalPrice'];
    this.priceWithDelivery = doc.data['priceWithDelivery'];
    if (doc.data['additionDish'] != null) {
      this.additionDish = new List();
      for (var value in doc.data['additionDish']) {
        this.additionDish.add(AdditionDish.doc(value));
      }
    }
    this.notifyListeners();
  }

  void fromPostedDish(PostedDish doc) {
    this.name = doc.name ?? '';
    this.id = doc.id;
    this.makerId = doc.makerId;
    this.salesNumber = doc.salesNumber;
    this.totalService = doc.totalService;
    this.category = doc.category;
    this.salesDate = doc.salesDate;
    this.startTime = doc.startTime;
    this.endTime = doc.endTime;
    this.currentLocation = doc.currentLocation;
    this.dishPictureURI = doc.dishPictureURI;
    this.status = doc.status;
    this.originalPrice = doc.originalPrice;
    this.priceWithDelivery = doc.priceWithDelivery;
    if (doc.additionDish != null) {
      this.additionDish = [];
      this.additionDish.addAll(doc.additionDish);
    }
    this.notifyListeners();
  }
}
 */
