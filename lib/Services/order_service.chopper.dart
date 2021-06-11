// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$OrderService extends OrderService {
  _$OrderService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = OrderService;

  Future<Response> ordersDetailbySeller(int sellerId) {
    final $url = '/order/detail/list/${sellerId}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> ordersDetailbyId(int orderDetailId) {
    final $url = '/order/detail/seller/order/${orderDetailId}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateOrderStateById(int id, int state) {
    final $url = '/order/update/state/${id}/';
    final $body = {'state': state};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
