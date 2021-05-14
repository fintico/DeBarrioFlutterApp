import 'dart:core';

class BankCard {
  ///Card unique Id
  String cardId;

  ///Card holder name
  String cardName;

  ///Card Expiry date MM/YY
  String cardExpiry;

  ///Card number printed on card
  String cardNumber;

  ///Card secret key written on card's Back
  String cardKey;

  Map<String, dynamic> toMap() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'cardExpiry': cardExpiry,
      'cardNumber': cardNumber,
      'cardKey': cardKey,
    };
  }

  BankCard.doc(var doc) {
    this.fromMap(doc);
  }
  BankCard(
      {this.cardId,
      this.cardName,
      this.cardExpiry,
      this.cardNumber,
      this.cardKey});

  void fromMap(var doc) {
    this.cardId = doc['cardId'] ?? '';
    this.cardName = doc['cardName'] ?? '';
    this.cardExpiry = doc['cardExpiry'] ?? '';
    this.cardNumber = doc['cardNumber'] ?? '';
    this.cardKey = doc['cardKey'] ?? '';
  }
}
