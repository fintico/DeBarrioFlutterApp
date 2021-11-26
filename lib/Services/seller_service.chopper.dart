// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SellerService extends SellerService {
  _$SellerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SellerService;

  @override
  Future<Response<dynamic>> getDishesBySeller() {
    final $url = '/seller/dish/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDishesBySellerFilter(
      int category, String deliveryDate) {
    final $url = '/seller/dish/list/filter/';
    final $params = <String, dynamic>{
      'category': category,
      'delivery_date': deliveryDate
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postSeller(int userId) {
    final $url = '/seller/create/';
    final $body = <String, dynamic>{'user': userId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putSeller(int userId, String restaurantName) {
    final $url = '/seller/update/$userId/';
    final $body = <String, dynamic>{'restaurant_name': restaurantName};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateStateBySeller(int id, bool isActive) {
    final $url = '/seller/address/update/$id/';
    final $body = <String, dynamic>{'is_active': isActive};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateImage(
      int userId, String urlImage, String url) {
    final $url = '/seller/update/image/$userId/';
    final $parts = <PartValue>[
      PartValue<String>('urlImage', urlImage),
      PartValueFile<String>('urlImage', url)
    ];
    final $request =
        Request('PUT', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
