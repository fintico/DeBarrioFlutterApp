import 'package:chopper/chopper.dart';
part 'register_service.chopper.dart';

//flutter packages pub run build_runner watch

@ChopperApi(baseUrl: '/auth')
abstract class RegisterService extends ChopperService {
  static const API_BASE_URL = 'http://10.0.2.2:8000';
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/verify_code/')
  Future<Response> postVerifyCode(
      @Field('code') String code, @Field('username') String username);

  @Post(path: '/retry_verify_code/')
  Future<Response> retrySMSRegistration(
      @Field('code') String code, @Field('username') String username);

  @Post(path: '/register/')
  Future<Response> postUserRegister(
      @Field('code') String code, @Field('username') String username);

  @Post(path: '/login/')
  Future<Response> postUserLogin(
      @Field('code') String code, @Field('username') String username);

  static RegisterService create() {
    final client = ChopperClient(
      baseUrl: API_BASE_URL,
      services: [_$RegisterService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: FormUrlEncodedConverter(),
    );
    return _$RegisterService(client);
  }
}
