// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SellerService extends SellerService {
  _$SellerService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SellerService;

  Future<Response> addressbySeller(int sellerId) {
    final $url = '/seller/address/list/${sellerId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishesBySeller() {
    final $url = '/seller/dish/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getDishesBySellerFilter(int category, String deliveryDate) {
    final $url = '/seller/dish/list/filter/';
    final Map<String, dynamic> $params = {
      'category': category,
      'delivery_date': deliveryDate
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postSeller(int userId) {
    final $url = '/seller/create/';
    final $body = {'user': userId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateStateBySeller(int id, bool isActive) {
    final $url = '/seller/address/update/${id}/';
    final $body = {'is_active': isActive};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateImage(int userId, String urlImage, String url) {
    final $url = '/seller/update/image/${userId}/';
    final $parts = <PartValue>[
      PartValue<String>('urlImage', urlImage),
      PartValueFile<String>('urlImage', url)
    ];
    final $request =
        Request('PUT', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
