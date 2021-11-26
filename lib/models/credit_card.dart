import 'card_type.dart';

class CreditCard {
  int? id;
  CardType? cardType;
  String? cardNumber;
  String? cardHolder;
  String? expiredDate;
  String? cvv;
  bool? isDeleted;

  CreditCard({
    this.id,
    this.cardType,
    this.cardNumber,
    this.cardHolder,
    this.expiredDate,
    this.cvv,
    this.isDeleted,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'] as int,
      cardType: json['card_type'] == null
          ? null
          : CardType.fromJson(json['card_type'] as Map<String, dynamic>),
      cardNumber: json['card_number'] as String,
      cardHolder: json['card_holder'] as String,
      expiredDate: json['expired_date'] as String,
      cvv: json['cvv'] as String,
      isDeleted: json['is_deleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_type': cardType?.toJson(),
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expired_date': expiredDate,
      'cvv': cvv,
      'is_deleted': isDeleted,
    };
  }
}
