import 'package:chopper/chopper.dart';
part 'location_service.chopper.dart';

@ChopperApi(baseUrl: '/location')
abstract class LocationService extends ChopperService {
  static const API_BASE_URL = 'http://10.0.2.2:8000';
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/create/')
  Future<Response> postUserLocation(
    @Field('address_name') String addressName,
    @Field('is_active') bool isActive,
    @Field('longitude') double longitude,
    @Field('latitude') double latitude,
  );

  static LocationService create() {
    final client = ChopperClient(
      baseUrl: API_BASE_URL,
      services: [_$LocationService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$LocationService(client);
  }
}
