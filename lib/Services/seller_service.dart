import 'dart:io';

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

  @Get(path: '/dish/list/')
  Future<Response> getDishesBySeller();

  @Get(path: '/dish/list/filter/')
  Future<Response> getDishesBySellerFilter(
    @Query('category') int category,
    @Query('delivery_date') String deliveryDate,
  );

  @Post(path: '/create/')
  Future<Response> postSeller(
    @Field('user') int userId,
  );

  @Put(path: '/update/{user_id}/')
  Future<Response> putSeller(
    @Path("user_id") int userId,
    @Field('restaurant_name') String restaurantName,
  );

  @Put(path: '/address/update/{id}/')
  Future<Response> updateStateBySeller(
    @Path("id") int id,
    @Field('is_active') bool isActive,
  );

  @Multipart()
  @Put(path: '/update/image/{user_id}/')
  Future<Response> updateImage(
    @Path("user_id") int userId,
    @Part("urlImage") String urlImage,
    @PartFile('urlImage') String url,
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
