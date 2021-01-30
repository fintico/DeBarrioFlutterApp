import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
class InAppAddress {
  String addressId;
  GeoPoint addressLanLon;
  String addressString;
  String addressDescription;

  Map<String, dynamic> toMap() {
    return {
      'addressId': addressId,
      'addressLanLon': addressLanLon,
      'addressString': addressString,
      'addressDescription': addressDescription,
    };
  }
  InAppAddress.doc(var doc){
    this.fromMap(doc);
  }
  InAppAddress(
      {this.addressId,
        this.addressLanLon,
        this.addressDescription,
        this.addressString
      });

  void fromMap(var doc) {
    this.addressId = doc['addressId'] ?? '';
    this.addressLanLon = doc['addressLanLon'] ?? '';
    this.addressString = doc['addressString'] ?? '';
    this.addressDescription = doc['addressDescription'] ?? '';
  }
}


