// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$OrderService extends OrderService {
  _$OrderService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = OrderService;

  @override
  Future<Response<dynamic>> postOrder(
      bool isDelivery,
      bool isPickup,
      double totalPrice,
      double subtotalPrice,
      double tip,
      int state,
      int portion,
      String deliveryDate,
      String? deliveryTime,
      bool isActive,
      bool isDeleted,
      int customerAddress,
      int creditCard) {
    final $url = '/order/create/';
    final $body = <String, dynamic>{
      'is_delivery': isDelivery,
      'is_pickup': isPickup,
      'total_price': totalPrice,
      'subtotal_price': subtotalPrice,
      'tip': tip,
      'state': state,
      'portion': portion,
      'delivery_date': deliveryDate,
      'delivery_time': deliveryTime,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'customer_address': customerAddress,
      'credit_card': creditCard
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postOrderDish(int orderId, int dishId) {
    final $url = '/order/detail/create/';
    final $body = <String, dynamic>{'order': orderId, 'dish': dishId};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> ordersDetailbySeller(int sellerId) {
    final $url = '/order/detail/list/$sellerId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> ordersDetailbyCustomer(int customerId) {
    final $url = '/order/detail/customer/list/$customerId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> ordersDetailbyId(int orderDetailId) {
    final $url = '/order/detail/$orderDetailId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateOrderStateById(int id, int state) {
    final $url = '/order/update/state/$id/';
    final $body = <String, dynamic>{'state': state};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
