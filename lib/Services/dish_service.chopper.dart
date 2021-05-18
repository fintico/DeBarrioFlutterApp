// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$DishService extends DishService {
  _$DishService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = DishService;

  Future<Response> postSellerDish(
      String dishName,
      String urlImage,
      int stock,
      String deliveryDate,
      String deliveryFromTime,
      String deliveryToTime,
      double deliveryPrice,
      double pickUpPrice,
      int sellerId,
      int categoryId,
      int additionalId) {
    final $url = '/dish/create/';
    final $body = {
      'dish_name': dishName,
      'image': urlImage,
      'stock': stock,
      'delivery_date': deliveryDate,
      'delivery_time_from': deliveryFromTime,
      'delivery_time_to': deliveryToTime,
      'price_delivery': deliveryPrice,
      'price_pickup': pickUpPrice,
      'seller': sellerId,
      'dish_category': categoryId,
      'additional': additionalId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postAdditionalDish(
      String additionalDescription, double price, bool isFree) {
    final $url = '/dish/additional/create/';
    final $body = {
      'additional_description': additionalDescription,
      'price': price,
      'is_free': isFree
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishList() {
    final $url = '/dish/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishById(int dishId) {
    final $url = '/dish/detail/${dishId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
