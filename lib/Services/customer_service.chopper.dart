// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$CustomerService extends CustomerService {
  _$CustomerService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = CustomerService;

  Future<Response> customerSearchById(int customerId) {
    final $url = '/customer/search/list/${customerId}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postCustomerSearchCreate(int customerId, int dishId) {
    final $url = '/customer/search/create/';
    final $body = {'customer_search': customerId, 'dish_search': dishId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
