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
    final $body = {
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

  Future<Response> updateDishImage(int dishId, String urlImage, String url) {
    final $url = '/dish/update/image/${dishId}/';
    final $parts = <PartValue>[
      PartValue<String>('urlImage', urlImage),
      PartValueFile<String>('urlImage', url)
    ];
    final $request =
        Request('PUT', $url, client.baseUrl, parts: $parts, multipart: true);
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

  Future<Response> deleteDish(int dishId, bool isActive) {
    final $url = '/dish/delete/state/${dishId}';
    final $body = {'is_active': isActive};
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateDish(
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
    final $url = '/dish/update/${dishId}';
    final $body = {
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

  Future<Response> getDishList() {
    final $url = '/dish/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishBySellerList(int sellerId) {
    final $url = '/dish/seller/list/${sellerId}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishByName(String dishName) {
    final $url = '/dish/list/${dishName}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishById(int dishId) {
    final $url = '/dish/detail/${dishId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
