import 'package:debarrioapp/Screens/Registration/map_loaction_set.dart';
import 'package:debarrioapp/Screens/dish.dart';
import 'package:debarrioapp/Screens/map_screen.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/widgets/dish/dish_additional_page.dart';
import 'package:debarrioapp/widgets/dish/dish_detail_page.dart';
import 'package:debarrioapp/widgets/dish/dish_publish_page.dart';
import 'package:debarrioapp/widgets/dish/dish_publish_splash.dart';
import 'package:debarrioapp/widgets/home/home_page.dart';
import 'package:debarrioapp/widgets/location/location_page.dart';
import 'package:debarrioapp/widgets/location/location_splash_loading.dart';
import 'package:debarrioapp/widgets/registration/registration_splash.dart';
import 'package:debarrioapp/widgets/verify/verify_sms_page.dart';
import 'package:debarrioapp/widgets/verify/verify_splash_loading.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static const VERIFY_SMS = '/verify_sms';
  static const REGISTRATION_LOCATION = '/location_confirm';
  static const HOME_SCREEN = '/home_screen';

  //Dish
  static const DISH_ADDITIONAL_SCREEN = '/dish_additional_screen';
  static const DISH_PUBLISH_SCREEN = '/dish_publish_screen';
  static const DISH_DETAIL_SCREEN = '/dish_detail_screen';

  static const SPLASH_LOADING_REGISTRATION_SCREEN = '/splash_loading_screen';
  static const SPLASH_LOADING_VERIFICATION_SMS_SCREEN =
      '/splash_validation_screen';
  static const SPLASH_LOADING_LOCATION_SCREEN =
      '/splash_loading_location_screen';

  static const SPLASH_LOADING_PUBLISH_DISH_SCREEN =
      '/splash_loading_publish_dish_screen';

  static const SPLASH_CONFIRM_DISH_PUBLISH_SCREEN =
      '/splash_confirm_publish_dish_screen';

  static void createRoutes() {
    var mainRoutes = [
      SailorRoute(
        name: REGISTRATION_LOCATION,
        builder: (context, args, params) {
          return LocationPage();
        },
      ),
      SailorRoute(
        name: HOME_SCREEN,
        builder: (_, __, ___) {
          return HomePage();
        },
      ),
      SailorRoute(
        name: DISH_PUBLISH_SCREEN,
        builder: (_, __, ___) {
          return DishPublish();
        },
      ),
      SailorRoute(
        name: DISH_ADDITIONAL_SCREEN,
        builder: (_, __, ___) {
          return DishAdditional();
        },
      ),
      SailorRoute(
        name: DISH_DETAIL_SCREEN,
        builder: (_, __, ___) {
          return DishDetail();
        },
      ),
    ];

    var routesSplash = [
      SailorRoute(
        name: SPLASH_LOADING_REGISTRATION_SCREEN,
        builder: (context, args, params) {
          return RegistrationSplash();
        },
      ),
      SailorRoute(
        name: SPLASH_LOADING_VERIFICATION_SMS_SCREEN,
        builder: (context, args, params) {
          return VerificationSMSLoading();
        },
      ),
      SailorRoute(
        name: SPLASH_LOADING_LOCATION_SCREEN,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: LocationSplash(),
          );
        },
      ),
      SailorRoute(
        name: SPLASH_LOADING_PUBLISH_DISH_SCREEN,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: DishSplash(),
          );
        },
      ),
      SailorRoute(
        name: SPLASH_CONFIRM_DISH_PUBLISH_SCREEN,
        builder: (context, args, params) {
          return Material(
            child: DishConfirm(),
          );
        },
      ),
    ];

    var routesRegistration = [
      SailorRoute(
        name: VERIFY_SMS,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: VerifySMSPage(
              args: args,
            ),
          );
        },
      ),
    ];

    sailor.addRoutes(mainRoutes);
    sailor.addRoutes(routesSplash);
    sailor.addRoutes(routesRegistration);
  }
}
