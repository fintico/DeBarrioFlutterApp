import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;
part 'order_service.chopper.dart';

@ChopperApi(baseUrl: '/order')
abstract class OrderService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Get(path: '/detail/list/{seller_id}/')
  Future<Response> ordersDetailbySeller(@Path("seller_id") int sellerId);

  @Get(path: '/detail/seller/order/{id}/')
  Future<Response> ordersDetailbyId(@Path("id") int orderDetailId);

  @Put(path: '/update/state/{id}/')
  Future<Response> updateOrderStateById(
    @Path("id") int id,
    @Field('state') int state,
  );

  static OrderService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$OrderService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$OrderService(client);
  }
}
