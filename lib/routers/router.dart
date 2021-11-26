import 'package:debarrioapp/Screens/Registration/map_loaction_set.dart';
import 'package:debarrioapp/Screens/dish.dart';
import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/widgets/calendar/calendar_page.dart';
import 'package:debarrioapp/widgets/dish/dish_additional_page.dart';
import 'package:debarrioapp/widgets/dish/dish_detail_page.dart';
import 'package:debarrioapp/widgets/dish/dish_location_page.dart';
import 'package:debarrioapp/widgets/dish/dish_publish_page.dart';
import 'package:debarrioapp/widgets/dish/dish_publish_splash.dart';
import 'package:debarrioapp/widgets/home/home_page.dart';
import 'package:debarrioapp/widgets/location/location_page.dart';
import 'package:debarrioapp/widgets/location/location_splash_loading.dart';
import 'package:debarrioapp/widgets/menu/menu_page.dart';
import 'package:debarrioapp/widgets/menu/order/finish_order/order_detail_finish_page.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_page.dart';
import 'package:debarrioapp/widgets/menu/order/order_home_page.dart';
import 'package:debarrioapp/widgets/menu/order/order_payment_summary_page.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_add_card_page.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_loading_splash.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_page.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_pay_page.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_pay_splash.dart';
import 'package:debarrioapp/widgets/menu/profile/profile_home_page.dart';
import 'package:debarrioapp/widgets/menu/profile/profile_update_page.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_delete_splash.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_detail_page.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_page.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_republish_page.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_republish_splash.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_details_delivered_page.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_details_page.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_details_prepared_page.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_page.dart';
import 'package:debarrioapp/widgets/purchase/purchase_home_page.dart';
import 'package:debarrioapp/widgets/registration/registration_splash.dart';
import 'package:debarrioapp/widgets/search/search_page.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_empty_splash.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_home_page.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_order_placed_splash.dart';
import 'package:debarrioapp/widgets/verify/verify_sms_page.dart';
import 'package:debarrioapp/widgets/verify/verify_splash_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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

  //myposts
  static const DISH_LIST_SCREEN = '/dish_list_screen';
  static const DISH_PUBLISH_DETAIL = '/dish_publish_detail_screen';
  static const DISH_REPUBLISH_SCREEN = '/dish_republish_screen';

  //mysells
  static const SALE_LIST_SCREEN = '/sale_list_screen';
  static const SALE_DETAILS_SCREEN = '/sale_details_screen';
  static const SALE_DETAILS_PREPARED_SCREEN = '/sale_details_prepared_screen';
  static const SALE_DETAILS_DELIVERED_SCREEN = '/sale_details_delivered_screen';

  //payment method
  static const PAYMENT_METHOD_LIST_SCREEN = '/payment_method_list_screen';
  static const PAYMENT_METHOD_ADD_CARD_SCREEN =
      '/payment_method_add_card_screen';
  static const PAYMENT_METHOD_PAY_SCREEN = '/payment_method_pay_screen';

  //order
  static const ORDER_HOME_PAGE_SCREEN = '/order_home_page_screen';
  static const ORDER_DETAIL_FINISH_SCREEN = '/order_detail_finish_screen';
  static const ORDER_DETAIL_ONGOING_SCREEN = '/order_detail_ongoing_screen';
  static const ORDER_PAYMENT_SUMMARY_SCREEN = '/order_payment_summary_screen';

  //search
  static const SEARCH_SCREEN = '/search_screen';

  //Menu
  static const MENU_SCREEN = '/menu_screen';

  //calendar
  static const CALENDAR_SCREEN = '/calendar_screen';

  //location
  static const LOCATION_CHANGE_PAGE = '/location_change_page';

  //purchase
  static const PURCHASE_HOME_SCREEN = '/purchase_home_screen';

  //shopping
  static const SHOPPING_CART_HOME_SCREEN = '/shopping_cart_home_screen';

  //profile
  static const PROFILE_HOME_SCREEN = '/profile_home_screen';
  static const PROFILE_UPDATE_SCREEN = '/profile_update_screen';

  static const SPLASH_LOADING_REGISTRATION_SCREEN = '/splash_loading_screen';
  static const SPLASH_LOADING_VERIFICATION_SMS_SCREEN =
      '/splash_validation_screen';
  static const SPLASH_LOADING_LOCATION_SCREEN =
      '/splash_loading_location_screen';

  static const SPLASH_LOADING_PUBLISH_DISH_SCREEN =
      '/splash_loading_publish_dish_screen';

  static const SPLASH_CONFIRM_DISH_PUBLISH_SCREEN =
      '/splash_confirm_publish_dish_screen';

  static const SPLASH_LOADING_DISH_DELETE_SCREEN =
      '/splash_loading_dish_delete_screen';

  static const SPLASH_LOADING_REPUBLISH_SCREEN =
      '/splash_loading_republish_screen';

  static const SPLASH_LOADING_ADD_CREDIT_CARD_SCREEN =
      '/splash_loading_add_credit_card_screen';

  static const SPLASH_PAY_CREDIT_CARD_SCREEN =
      '/splash_play_credit_card_screen';

  static const SPLASH_CONFIRM_ORDER_PLACED_SCREEN =
      '/splash_confirm_order_placed_screen';

  static const SPLASH_EMPTY_CART_SCREEN = '/splash_empty_cart_screen';

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
        builder: (_, __, params) {
          final dishId = params.param<int>('dishId');
          return DishDetail(
            dishId: dishId,
          );
        },
        params: [
          SailorParam<int>(
            name: 'dishId',
          ),
        ],
      ),
      SailorRoute(
        name: DISH_LIST_SCREEN,
        builder: (_, __, ___) {
          return PublishPage();
        },
      ),
      SailorRoute(
        name: DISH_PUBLISH_DETAIL,
        builder: (_, __, params) {
          final id = params.param<int>('id');
          final isActive = params.param<bool>('isActive');
          final dishModel = params.param<DishModel>('dishModel');
          return PublishDetail(
            dishId: id,
            isActive: isActive,
            dishModel: dishModel,
          );
        },
        params: [
          SailorParam<int>(
            name: 'id',
            defaultValue: 1,
          ),
          SailorParam<bool>(
            name: 'isActive',
            defaultValue: false,
          ),
          SailorParam<DishModel>(name: 'dishModel'),
        ],
      ),
      SailorRoute(
        name: DISH_REPUBLISH_SCREEN,
        builder: (_, __, params) {
          final dishModel = params.param<DishModel>('dishModel');
          final address = params.param<Address>('address');
          return RepublishPage(
            dishModel: dishModel,
            address: address,
          );
        },
        params: [
          SailorParam<DishModel>(name: 'dishModel'),
          SailorParam<Address>(name: 'address'),
        ],
      ),
      SailorRoute(
        name: MENU_SCREEN,
        builder: (_, __, ___) {
          return MenuPage();
        },
      ),
      SailorRoute(
        name: CALENDAR_SCREEN,
        builder: (_, __, ___) {
          return CalendarPage();
        },
      ),
      SailorRoute(
        name: LOCATION_CHANGE_PAGE,
        builder: (_, __, ___) {
          return DishLocation();
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
          final dishId = params.param<int>('dishId');
          return Material(
            child: DishConfirm(
              dishId: dishId,
            ),
          );
        },
        params: [
          SailorParam<int>(
            name: 'dishId',
          ),
        ],
      ),
      SailorRoute(
        name: SPLASH_LOADING_DISH_DELETE_SCREEN,
        builder: (context, args, params) {
          final id = params.param<int>('id');
          return Material(
            type: MaterialType.transparency,
            child: PublishDelete(
              dishId: id,
            ),
          );
        },
        params: [
          SailorParam<int>(
            name: 'id',
            defaultValue: 1,
          ),
        ],
      ),
      SailorRoute(
        name: SPLASH_LOADING_REPUBLISH_SCREEN,
        builder: (context, args, params) {
          final dishModel = params.param<DishModel>('dishModel');
          return Material(
            type: MaterialType.transparency,
            child: RepublishSplash(
              dishModel: dishModel,
            ),
          );
        },
        params: [
          SailorParam<DishModel>(
            name: 'dishModel',
          ),
        ],
      ),
      SailorRoute(
        name: SPLASH_LOADING_ADD_CREDIT_CARD_SCREEN,
        builder: (context, args, params) {
          final creditCard = params.param<CreditCardModel>('creditCard');
          return Material(
            type: MaterialType.transparency,
            child: CreditCardAddSplash(
              creditCard: creditCard,
            ),
          );
        },
        params: [
          SailorParam<CreditCardModel>(
            name: 'creditCard',
          ),
        ],
      ),
      SailorRoute(
        name: SPLASH_PAY_CREDIT_CARD_SCREEN,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: CreditCardPaySplash(),
          );
        },
      ),
      SailorRoute(
        name: SPLASH_CONFIRM_ORDER_PLACED_SCREEN,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: ShoppingCartOrderPlacedSplash(),
          );
        },
      ),
      SailorRoute(
        name: SPLASH_EMPTY_CART_SCREEN,
        builder: (_, __, ___) {
          return ShoppingCartEmptySplash();
        },
      ),
    ];

    var routesSale = [
      SailorRoute(
        name: SALE_LIST_SCREEN,
        builder: (_, __, ___) {
          return SalePage();
        },
      ),
      SailorRoute(
        name: SALE_DETAILS_SCREEN,
        builder: (_, __, params) {
          final orderDetail = params.param<OrderDetail>('orderDetail');
          final stateOrder = params.param<int>('stateOrder');
          return SaleDetails(
            orderDetail: orderDetail,
            stateOrder: stateOrder,
          );
        },
        params: [
          SailorParam<OrderDetail>(
            name: 'orderDetail',
          ),
          SailorParam<int>(
            name: 'stateOrder',
          ),
        ],
      ),
      SailorRoute(
        name: SALE_DETAILS_PREPARED_SCREEN,
        builder: (_, __, params) {
          final orderDetail = params.param<OrderDetail>('orderDetail');
          return SaleDetailsPrepared(
            orderDetail: orderDetail,
          );
        },
        params: [
          SailorParam<OrderDetail>(
            name: 'orderDetail',
          ),
        ],
      ),
      SailorRoute(
        name: SALE_DETAILS_DELIVERED_SCREEN,
        builder: (_, __, params) {
          final orderDetail = params.param<OrderDetail>('orderDetail');
          return SaleDetailsDelivered(
            orderDetail: orderDetail,
          );
        },
        params: [
          SailorParam<OrderDetail>(
            name: 'orderDetail',
          ),
        ],
      ),
    ];

    var routesOrder = [
      SailorRoute(
        name: ORDER_HOME_PAGE_SCREEN,
        builder: (_, __, ___) {
          return HomeOrderPage();
        },
      ),
      SailorRoute(
        name: ORDER_DETAIL_FINISH_SCREEN,
        builder: (_, __, ___) {
          return OrderDetailFinish();
        },
      ),
      SailorRoute(
        name: ORDER_DETAIL_ONGOING_SCREEN,
        builder: (_, __, ___) {
          return OrderDetailOngoing();
        },
      ),
      SailorRoute(
        name: ORDER_PAYMENT_SUMMARY_SCREEN,
        builder: (_, __, params) {
          final type = params.param<int>('type');
          return OrderPaymentSummary(
            type: type,
          );
        },
        params: [
          SailorParam<int>(name: 'type'),
        ],
      ),
    ];

    var routesPaymentMethod = [
      SailorRoute(
        name: PAYMENT_METHOD_ADD_CARD_SCREEN,
        builder: (_, __, ___) {
          return PaymentMethodAddCard();
        },
      ),
      SailorRoute(
        name: PAYMENT_METHOD_LIST_SCREEN,
        builder: (_, __, params) {
          final isCreated = params.param<bool>('isCreated');
          return PaymentMethodPage(
            isCreated: isCreated,
          );
        },
        params: [
          SailorParam<bool>(name: 'isCreated', defaultValue: true),
        ],
      ),
      SailorRoute(
        name: PAYMENT_METHOD_PAY_SCREEN,
        builder: (_, __, ___) {
          return PaymentMethodPay();
        },
      ),
    ];

    var routesSearch = [
      SailorRoute(
        name: SEARCH_SCREEN,
        builder: (_, __, ___) {
          return SearchPage();
        },
      ),
    ];

    var routesPurchase = [
      SailorRoute(
        name: PURCHASE_HOME_SCREEN,
        builder: (_, __, params) {
          final sellerDish = params.param<SellerDetail>('sellerDish');
          return PurchasePage(
            sellerDish: sellerDish,
          );
        },
        params: [
          SailorParam<SellerDetail>(name: 'sellerDish'),
        ],
      ),
    ];

    var routesShoppingCart = [
      SailorRoute(
        name: SHOPPING_CART_HOME_SCREEN,
        builder: (_, __, ___) {
          //final sellerDish = params.param<SellerDish>('sellerDish');
          return ShoppingCartHome();
        },
/*         params: [
          SailorParam<SellerDish>(name: 'sellerDish'),
        ], */
      ),
    ];

    var routesRegistration = [
      SailorRoute(
        name: VERIFY_SMS,
        builder: (context, args, params) {
          return Material(
            type: MaterialType.transparency,
            child: VerifySMSPage(
                //args: args,
                ),
          );
        },
      ),
    ];

    var routesProfile = [
      SailorRoute(
        name: PROFILE_HOME_SCREEN,
        builder: (_, __, ___) {
          //final sellerDish = params.param<SellerDish>('sellerDish');
          return ProfileHomePage();
        },
      ),
      SailorRoute(
        name: PROFILE_UPDATE_SCREEN,
        builder: (_, __, ___) {
          //final sellerDish = params.param<SellerDish>('sellerDish');
          return ProfileUpdate();
        },
      ),
    ];

    sailor.addRoutes(mainRoutes);
    sailor.addRoutes(routesSplash);
    sailor.addRoutes(routesRegistration);
    sailor.addRoutes(routesSale);
    sailor.addRoutes(routesPaymentMethod);
    sailor.addRoutes(routesSearch);
    sailor.addRoutes(routesPurchase);
    sailor.addRoutes(routesShoppingCart);
    sailor.addRoutes(routesProfile);
    sailor.addRoutes(routesOrder);
  }
}
