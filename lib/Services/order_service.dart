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

  @Post(path: '/create/')
  Future<Response> postOrder(
    @Field('is_delivery') bool isDelivery,
    @Field('is_pickup') bool isPickup,
    @Field('total_price') double totalPrice,
    @Field('subtotal_price') double subtotalPrice,
    @Field('tip') double tip,
    @Field('state') int state,
    @Field('portion') int portion,
    @Field('delivery_date') String deliveryDate,
    @Field('delivery_time') String? deliveryTime,
    @Field('is_active') bool isActive,
    @Field('is_deleted') bool isDeleted,
    @Field('customer_address') int customerAddress,
    @Field('credit_card') int creditCard,
  );

  @Post(path: '/detail/create/')
  Future<Response> postOrderDish(
    @Field('order') int orderId,
    @Field('dish') int dishId,
  );

  @Get(path: '/detail/list/{seller_id}/')
  Future<Response> ordersDetailbySeller(@Path("seller_id") int sellerId);

  @Get(path: '/detail/customer/list/{customer_id}/')
  Future<Response> ordersDetailbyCustomer(@Path("customer_id") int customerId);

  @Get(path: '/detail/{id}/')
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
