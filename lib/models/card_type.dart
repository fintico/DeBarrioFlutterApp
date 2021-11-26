class CardType {
  int? id;
  String? cardTypeDescription;

  CardType({this.id, this.cardTypeDescription});

  factory CardType.fromJson(Map<String, dynamic> json) {
    return CardType(
      id: json['id'] as int,
      cardTypeDescription: json['card_type_description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_type_description': cardTypeDescription,
    };
  }
}
