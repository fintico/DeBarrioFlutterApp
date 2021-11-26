import 'package:debarrioapp/Services/customer_service.dart';
import 'package:debarrioapp/Services/dish_service.dart';
import 'package:debarrioapp/Services/location_service.dart';
import 'package:debarrioapp/Services/order_service.dart';
import 'package:debarrioapp/Services/payment_service.dart';
import 'package:debarrioapp/Services/rating_service.dart';
import 'package:debarrioapp/Services/register_service.dart';
import 'package:debarrioapp/Services/seller_address_service.dart';
import 'package:debarrioapp/Services/seller_service.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/providers/location_provider.dart';
import 'package:debarrioapp/providers/register_provider.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLogin = GetIt.I;
final GetIt serviceSeller = GetIt.I;
final GetIt serviceCustomer = GetIt.I;
final GetIt locationService = GetIt.I;
final GetIt sellerAddressService = GetIt.I;
final GetIt customerAddressService = GetIt.I;
final GetIt dishService = GetIt.I;
final GetIt orderService = GetIt.I;
final GetIt paymentService = GetIt.I;
final GetIt ratingService = GetIt.I;
final GetIt registerProvider = GetIt.I;
final GetIt locationProvider = GetIt.I;
final GetIt homeProvider = GetIt.I;
final GetIt dishProvider = GetIt.I;

void setupLocator() {
  serviceLogin.registerLazySingleton(
    () => RegisterService.create(),
    instanceName: 'RegisterService',
  );

  serviceSeller.registerLazySingleton(
    () => SellerService.create(),
    instanceName: 'SellerService',
  );

  serviceCustomer.registerLazySingleton(
    () => CustomerService.create(),
    instanceName: 'CustomerService',
  );

  locationService.registerLazySingleton(
    () => LocationService.create(),
    instanceName: 'LocationService',
  );

  sellerAddressService.registerLazySingleton(
    () => SellerAddressService.create(),
    instanceName: 'SellerAddressService',
  );

  dishService.registerLazySingleton(
    () => DishService.create(),
    instanceName: 'DishService',
  );

  orderService.registerLazySingleton(
    () => OrderService.create(),
    instanceName: 'OrderService',
  );

  paymentService.registerLazySingleton(
    () => PaymentService.create(),
    instanceName: 'PaymentService',
  );

  ratingService.registerLazySingleton(
    () => RatingService.create(),
    instanceName: 'RatingService',
  );

  registerProvider.registerSingleton<RegisterProvider>(RegisterProvider());
  locationProvider.registerSingleton<LocationProvider>(LocationProvider());
  homeProvider.registerSingleton<HomeBloc>(HomeBloc());
  dishProvider.registerSingleton<DishProvider>(DishProvider());
}
