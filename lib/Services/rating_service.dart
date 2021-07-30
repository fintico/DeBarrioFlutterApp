import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;

part 'rating_service.chopper.dart';

@ChopperApi(baseUrl: '/rating')
abstract class RatingService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/create/')
  Future<Response> postRateSeller(
    @Field('rated_value') int ratedValue,
    @Field('seller') int sellerId,
  );

  static RatingService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$RatingService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$RatingService(client);
  }
}
