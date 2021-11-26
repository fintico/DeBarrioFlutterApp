// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RegisterService extends RegisterService {
  _$RegisterService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RegisterService;

  @override
  Future<Response<dynamic>> postVerifyCode(String code, String username) {
    final $url = '/auth/verify_code/';
    final $body = <String, dynamic>{'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrySMSRegistration(String code, String username) {
    final $url = '/auth/retry_verify_code/';
    final $body = <String, dynamic>{'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUserRegister(String code, String username) {
    final $url = '/auth/register/';
    final $body = <String, dynamic>{'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUserLogin(String code, String username) {
    final $url = '/auth/login/';
    final $body = <String, dynamic>{'code': code, 'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> patchUser(int userId, String uid) {
    final $url = '/auth/update/$userId';
    final $body = <String, dynamic>{'uid': uid};
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
