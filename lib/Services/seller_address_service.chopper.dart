// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_address_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SellerAddressService extends SellerAddressService {
  _$SellerAddressService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SellerAddressService;

  @override
  Future<Response<dynamic>> postSellerAddress(
      int sellerId, int addressId, bool isActive) {
    final $url = '/seller_address/create/';
    final $body = <String, dynamic>{
      'seller': sellerId,
      'address': addressId,
      'is_active': isActive
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSellerDetail(int sellerId) {
    final $url = '/seller_address/detail/$sellerId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addressbySeller(int sellerId) {
    final $url = '/seller_address/list/$sellerId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
