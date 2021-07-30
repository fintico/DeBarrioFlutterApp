import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;

part 'seller_address_service.chopper.dart';

@ChopperApi(baseUrl: '/seller_address')
abstract class SellerAddressService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/create/')
  Future<Response> postSellerAddress(
    @Field('seller') int sellerId,
    @Field('address') int addressId,
    @Field('is_active') bool isActive,
  );

  @Get(path: '/detail/{seller}')
  Future<Response> getSellerDetail(
    @Path("seller") int sellerId,
  );

  static SellerAddressService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$SellerAddressService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$SellerAddressService(client);
  }
}
