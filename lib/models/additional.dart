class Additional {
  int? id;
  String? additionalDescription;
  double? price;
  bool? isFree;

  Additional({
    this.id,
    this.additionalDescription,
    this.price,
    this.isFree,
  });

  factory Additional.fromJson(Map<String, dynamic> json) {
    return Additional(
      id: json['id'] as int,
      additionalDescription: json['additional_description'] as String,
      price: json['price'] as double,
      isFree: json['is_free'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'additional_description': additionalDescription,
      'price': price,
      'is_free': isFree,
    };
  }
}
