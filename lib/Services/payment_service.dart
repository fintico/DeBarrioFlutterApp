import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;
part 'payment_service.chopper.dart';

@ChopperApi(baseUrl: '/payment')
abstract class PaymentService extends ChopperService {
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Get(path: '/credit_card/list/{customer_id}/')
  Future<Response> getCreditCardByCustomer(@Path("customer_id") int customerId);

  @Get(path: '/credit_card/list/')
  Future<Response> getCreditCards();

  @Post(path: '/credit_card/create/')
  Future<Response> postCreditCardCreate(
    @Field('card_number') String cardNumber,
    @Field('card_holder') String cardHolder,
    @Field('expired_date') String expiredDate,
    @Field('cvv') String cvv,
    @Field('is_deleted') bool isDeleted,
    @Field('card_type') int cardTypeId,
  );

  @Put(path: '/credit_card/update/state/{id}/')
  Future<Response> putUpdateStateByCreditCard(
    @Path("id") int id,
    @Field('is_deleted') bool isDeleted,
  );

  static PaymentService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$PaymentService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$PaymentService(client);
  }
}
