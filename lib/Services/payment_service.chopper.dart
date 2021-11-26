// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PaymentService extends PaymentService {
  _$PaymentService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PaymentService;

  @override
  Future<Response<dynamic>> getCreditCardByCustomer(int customerId) {
    final $url = '/payment/credit_card/list/$customerId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCreditCards() {
    final $url = '/payment/credit_card/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postCreditCardCreate(
      String cardNumber,
      String cardHolder,
      String expiredDate,
      String cvv,
      bool isDeleted,
      int cardTypeId,
      int customerId) {
    final $url = '/payment/credit_card/create/';
    final $body = <String, dynamic>{
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expired_date': expiredDate,
      'cvv': cvv,
      'is_deleted': isDeleted,
      'card_type': cardTypeId,
      'customer': customerId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putUpdateStateByCreditCard(int id, bool isDeleted) {
    final $url = '/payment/credit_card/update/state/$id/';
    final $body = <String, dynamic>{'is_deleted': isDeleted};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
