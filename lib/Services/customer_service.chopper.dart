// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CustomerService extends CustomerService {
  _$CustomerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CustomerService;

  @override
  Future<Response<dynamic>> postCustomer(int userId) {
    final $url = '/customer/create/';
    final $body = <String, dynamic>{'user': userId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCustomerAddress(
      int customerId, int addressId, bool isActive) {
    final $url = '/customer/address/create/';
    final $body = <String, dynamic>{
      'customer': customerId,
      'address': addressId,
      'is_active': isActive
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCustomerDetail(int customerId) {
    final $url = '/customer/address/detail/$customerId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> customerSearchById(int customerId) {
    final $url = '/customer/search/list/$customerId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCustomerSearchCreate(
      int customerId, int dishId) {
    final $url = '/customer/search/create/';
    final $body = <String, dynamic>{
      'customer_search': customerId,
      'dish_search': dishId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
