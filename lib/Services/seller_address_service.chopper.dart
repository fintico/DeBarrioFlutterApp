// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_address_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SellerAddressService extends SellerAddressService {
  _$SellerAddressService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SellerAddressService;

  Future<Response> postSellerAddress(
      int sellerId, int addressId, bool isActive) {
    final $url = '/seller_address/create/';
    final $body = {
      'seller': sellerId,
      'address': addressId,
      'is_active': isActive
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getSellerDetail(int sellerId) {
    final $url = '/seller_address/detail/${sellerId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> addressbySeller(int sellerId) {
    final $url = '/seller_address/list/${sellerId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
