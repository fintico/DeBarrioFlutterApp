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

  Future<Response> updateStateBySeller(int id, bool isActive) {
    final $url = '/seller/address/update/${id}/';
    final $body = {'is_active': isActive};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
