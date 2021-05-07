class Dish {
  static final Dish _dish = new Dish._internal();

  String dishName;
  int dishCategory;
  int dishStock;
  String urlImage;
  String dishDeliveryDate;
  String dishDeliveryFromTime;
  String dishDeliveryToTime;
  double dishDeliveryPrice;
  double dishPickUpPrice;
  int dishAddress;
  int dishAdditional;

  String category;
  String date;
  String timeFrom;
  String timeTo;

  Dish._internal();

  factory Dish() {
    return _dish;
  }
}

final dish = Dish();
