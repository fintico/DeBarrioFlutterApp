import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;

part 'seller_service.chopper.dart';

@ChopperApi(baseUrl: '/seller')
abstract class SellerService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Get(path: '/address/list/{seller_id}')
  Future<Response> addressbySeller(@Path("seller_id") int sellerId);

  @Put(path: '/address/update/{id}/')
  Future<Response> updateStateBySeller(
    @Path("id") int id,
    @Field('is_active') bool isActive,
  );

  static SellerService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$SellerService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$SellerService(client);
  }
}
