// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RegisterService extends RegisterService {
  _$RegisterService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = RegisterService;

  Future<Response> postVerifyCode(String code, String username) {
    final $url = '/auth/verify_code/';
    final $body = {'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> retrySMSRegistration(String code, String username) {
    final $url = '/auth/retry_verify_code/';
    final $body = {'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postUserRegister(String code, String username) {
    final $url = '/auth/register/';
    final $body = {'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postUserLogin(String code, String username) {
    final $url = '/auth/login/';
    final $body = {'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
