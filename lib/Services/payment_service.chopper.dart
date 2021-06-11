// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PaymentService extends PaymentService {
  _$PaymentService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = PaymentService;

  Future<Response> getCreditCardByCustomer(int customerId) {
    final $url = '/payment/credit_card/list/${customerId}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCreditCards() {
    final $url = '/payment/credit_card/list/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postCreditCardCreate(String cardNumber, String cardHolder,
      String expiredDate, String cvv, bool isDeleted, int cardTypeId) {
    final $url = '/payment/credit_card/create/';
    final $body = {
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expired_date': expiredDate,
      'cvv': cvv,
      'is_deleted': isDeleted,
      'card_type': cardTypeId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> putUpdateStateByCreditCard(int id, bool isDeleted) {
    final $url = '/payment/credit_card/update/state/${id}/';
    final $body = {'is_deleted': isDeleted};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
