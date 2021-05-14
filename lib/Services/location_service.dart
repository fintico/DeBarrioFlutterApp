import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;
part 'location_service.chopper.dart';

@ChopperApi(baseUrl: '/location')
abstract class LocationService extends ChopperService {
  //static const API_BASE_URL = 'http://10.0.2.2:8000';
  //static const API_BASE_URL = 'http://bbe3c5f07594.ngrok.io';
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/create/')
  Future<Response> postUserLocation(
    @Field('address_name') String addressName,
    @Field('address_description') String addressDescription,
    @Field('is_active') bool isActive,
    @Field('longitude') double longitude,
    @Field('latitude') double latitude,
  );

  @Get(path: '/list/')
  Future<Response> getLocationList();

  static LocationService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$LocationService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$LocationService(client);
  }
}
