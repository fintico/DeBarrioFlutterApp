import 'dart:core';

class AdditionDish {
  String additionName;
  String price;

  //Do not upload
  bool isSelected=false;

  Map<String, dynamic> toMap() {
    return {
      'additionName': additionName,
      'price': price,
    };
  }
  AdditionDish.doc(var doc){
    this.fromMap(doc);
  }
  AdditionDish(
      {this.additionName,
        this.price,
      });

  void fromMap(var doc) {
    this.additionName = doc['additionName'] ?? '';
    this.price = doc['price'] ?? '';
  }
}


