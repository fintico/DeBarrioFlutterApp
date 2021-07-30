import 'dart:collection';

import 'package:debarrioapp/models/credit_card.dart';
import 'package:flutter/material.dart';

class PaymentMethodBloc extends ChangeNotifier {
  bool creditCard = false;
  int indexCreditCard;
  int id;
  List<CreditCard> _creditCards = [];

  void onCreditCard(int index) {
    indexCreditCard = index + 1;
    print(index);
    notifyListeners();
  }

  void onId(int idTemp) {
    id = idTemp;
    print(id);
    notifyListeners();
  }

  UnmodifiableListView<CreditCard> get creditCards =>
      UnmodifiableListView(_creditCards);

  set creditCards(List<CreditCard> creditCards) {
    _creditCards = creditCards;
    notifyListeners();
  }
}
