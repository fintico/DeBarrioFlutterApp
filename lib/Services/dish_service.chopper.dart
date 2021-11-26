// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DishService extends DishService {
  _$DishService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DishService;

  @override
  Future<Response<dynamic>> postSellerDish(
      String dishName,
      int stock,
      String deliveryDate,
      String deliveryFromTime,
      String deliveryToTime,
      double deliveryPrice,
      double pickUpPrice,
      int sellerId,
      int categoryId,
      int additionalId,
      int addressId) {
    final $url = '/dish/create/';
    final $body = <String, dynamic>{
      'dish_name': dishName,
      'stock': stock,
      'delivery_date': deliveryDate,
      'delivery_time_from': deliveryFromTime,
      'delivery_time_to': deliveryToTime,
      'price_delivery': deliveryPrice,
      'price_pickup': pickUpPrice,
      'seller': sellerId,
      'dish_category': categoryId,
      'additional': additionalId,
      'address': addressId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateDishImage(
      int dishId, String urlImage, String url) {
    final $url = '/dish/update/image/$dishId/';
    final $parts = <PartValue>[
      PartValue<String>('urlImage', urlImage),
      PartValueFile<String>('urlImage', url)
    ];
    final $request =
        Request('PUT', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postAdditionalDish(
      String additionalDescription, double price, bool isFree) {
    final $url = '/dish/additional/create/';
    final $body = <String, dynamic>{
      'additional_description': additionalDescription,
      'price': price,
      'is_free': isFree
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteDish(int dishId, bool isActive) {
    final $url = '/dish/delete/state/$dishId';
    final $body = <String, dynamic>{'is_active': isActive};
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateDish(
      int dishId,
      String dishName,
      int stock,
      String deliveryDate,
      String deliveryFromTime,
      String deliveryToTime,
      double deliveryPrice,
      double pickUpPrice,
      bool isActive,
      bool isDeleted,
      int sellerId,
      int categoryId,
      int additionalId,
      int addressId) {
    final $url = '/dish/update/$dishId';
    final $body = <String, dynamic>{
      'dish_name': dishName,
      'stock': stock,
      'delivery_date': deliveryDate,
      'delivery_time_from': deliveryFromTime,
      'delivery_time_to': deliveryToTime,
      'price_delivery': deliveryPrice,
      'price_pickup': pickUpPrice,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'seller': sellerId,
      'dish_category': categoryId,
      'additional': additionalId,
      'address': addressId
    };
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDishList() {
    final $url = '/dish/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDishBySellerList(int sellerId) {
    final $url = '/dish/seller/list/$sellerId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDishByName(String dishName) {
    final $url = '/dish/list/$dishName/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDishById(int dishId) {
    final $url = '/dish/detail/$dishId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
