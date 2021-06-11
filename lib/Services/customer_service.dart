import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;

part 'customer_service.chopper.dart';

@ChopperApi(baseUrl: '/customer')
abstract class CustomerService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Get(path: '/search/list/{customer_id}/')
  Future<Response> customerSearchById(@Path("customer_id") int customerId);

  @Post(path: '/search/create/')
  Future<Response> postCustomerSearchCreate(
    @Field('customer_search') int customerId,
    @Field('dish_search') int dishId,
  );

  static CustomerService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$CustomerService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$CustomerService(client);
  }
}
