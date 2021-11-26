class AdditionalModel {
  int? id;
  String? additionalDescription;
  double? price;
  bool? isFree;

  AdditionalModel(
      {this.id, this.additionalDescription, this.price, this.isFree});

  AdditionalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    additionalDescription = json['additional_description'] as String;
    price = json['price'] as double;
    isFree = json['is_free'] as bool;
  }
}
