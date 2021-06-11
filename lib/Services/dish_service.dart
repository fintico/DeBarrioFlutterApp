import 'package:chopper/chopper.dart';
import 'package:debarrioapp/constants/url_base.dart' as Url;
part 'dish_service.chopper.dart';

@ChopperApi(baseUrl: '/dish')
abstract class DishService extends ChopperService {
  //static const API_BASE_URL = 'http://10.0.2.2:8000';
  //static const API_BASE_URL = API_BASE_URL;
  static var customHeaders = {
    'Accept': '*/*',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
  };

  @Post(path: '/create/')
  Future<Response> postSellerDish(
    @Field('dish_name') String dishName,
    @Field('image') String urlImage,
    @Field('stock') int stock,
    @Field('delivery_date') String deliveryDate,
    @Field('delivery_time_from') String deliveryFromTime,
    @Field('delivery_time_to') String deliveryToTime,
    @Field('price_delivery') double deliveryPrice,
    @Field('price_pickup') double pickUpPrice,
    @Field('seller') int sellerId,
    @Field('dish_category') int categoryId,
    @Field('additional') int additionalId,
    @Field('address') int addressId,
  );

  @Post(path: '/additional/create/')
  Future<Response> postAdditionalDish(
    @Field('additional_description') String additionalDescription,
    @Field('price') double price,
    @Field('is_free') bool isFree,
  );

  @Patch(path: '/delete/state/{id}')
  Future<Response> deleteDish(
      @Path("id") int dishId, @Field('is_active') bool isActive);

  @Put(path: '/update/{id}')
  Future<Response> updateDish(
    @Path("id") int dishId,
    @Field('dish_name') String dishName,
    @Field('image') String urlImage,
    @Field('stock') int stock,
    @Field('delivery_date') String deliveryDate,
    @Field('delivery_time_from') String deliveryFromTime,
    @Field('delivery_time_to') String deliveryToTime,
    @Field('price_delivery') double deliveryPrice,
    @Field('price_pickup') double pickUpPrice,
    @Field('is_active') bool isActive,
    @Field('is_deleted') bool isDeleted,
    @Field('seller') int sellerId,
    @Field('dish_category') int categoryId,
    @Field('additional') int additionalId,
    @Field('address') int addressId,
  );

  @Get(path: '/list/')
  Future<Response> getDishList();

  @Get(path: '/list/{dish_name}/')
  Future<Response> getDishByName(@Path("dish_name") String dishName);

  @Get(path: '/detail/{id}')
  Future<Response> getDishById(@Path("id") int dishId);

  static DishService create() {
    final client = ChopperClient(
      baseUrl: Url.API_BASE_URL,
      services: [_$DishService()],
      interceptors: [HeadersInterceptor(customHeaders), CurlInterceptor()],
      converter: JsonConverter(),
    );
    return _$DishService(client);
  }
}
