import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/Screens/Registration/OnBoardingScreen.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/providers/sale_provider.dart';
import 'package:debarrioapp/providers/search_provider.dart';
import 'package:debarrioapp/providers/shopping_cart_provider.dart';
import 'package:debarrioapp/services/seller_address_service.dart';
import 'package:debarrioapp/services/rating_service.dart';
import 'package:debarrioapp/services/customer_service.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/services/location_service.dart';
import 'package:debarrioapp/services/order_service.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/services/register_service.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/providers/location_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:debarrioapp/widgets/calendar/calendar_bloc.dart';
import 'package:debarrioapp/widgets/calendar/calendar_page.dart';
import 'package:debarrioapp/widgets/dish/dish_location_page.dart';
import 'package:debarrioapp/widgets/home/home_filter_page.dart';
import 'package:debarrioapp/widgets/menu/menu_page.dart';
import 'package:debarrioapp/widgets/menu/order/finish_order/order_detail_finish_page.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_page.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_page.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_details_page.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_route_delivery_page.dart';
import 'package:debarrioapp/widgets/purchase/purchase_home_page.dart';
import 'package:debarrioapp/widgets/search/search_page.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_home_page.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_order_placed_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart' as symbolLocal;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ModelClass/foodData.dart';
import 'ModelClass/orderList.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseAuthService.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

import 'Screens/Registration/phonenumber.dart';
import 'Screens/splash_screen.dart';
import 'widgets/home/home_page.dart';
import 'widgets/location/location_page.dart';
import 'widgets/menu/profile/profile_home_page.dart';
import 'widgets/registration/registration_page.dart';

int initScreen;

Future<void> main() async {
  Routes.createRoutes();
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  //SharedPreferences preferences = await SharedPreferences.getInstance();
  //initScreen = preferences.getInt('initScreen');
  //await preferences.setInt('initScreen', 1);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  //AuthService authService;
  //DatabaseService database;
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    //symbolLocal.initializeDateFormatting('es');
    // symbolLocal.initializeDateFormatting('es_US');
    return MultiProvider(
        providers: [
          /* ChangeNotifierProvider(create: (BuildContext context) => User()),
          ChangeNotifierProvider(
              create: (BuildContext context) => PostedDish()),
          ChangeNotifierProvider(create: (BuildContext context) => Order()),
          ChangeNotifierProvider(create: (BuildContext context) => FoodData()),
          ChangeNotifierProvider(create: (BuildContext context) => OrderList()), */
          ChangeNotifierProvider(create: (_) => CalendarBloc()),
          ChangeNotifierProvider(create: (_) => SaleBloc()),
          ChangeNotifierProvider(create: (_) => SearchBloc()),
          ChangeNotifierProvider(create: (_) => PurchaseBloc()),
          ChangeNotifierProvider(create: (_) => ShoppingCartBloc()),
          ChangeNotifierProvider(create: (_) => PaymentMethodBloc()),
          ChangeNotifierProvider(create: (_) => ProfileBloc()),
          ChangeNotifierProvider(create: (_) => OrderBloc()),
          ChangeNotifierProvider(create: (_) => HomeBloc()),
          ChangeNotifierProvider(create: (_) => DishProvider()),
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          Provider(
            create: (_) => RegisterService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => LocationService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => DishService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => SellerService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => OrderService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => PaymentService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => CustomerService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => RatingService.create(),
            dispose: (_, value) => value.client.dispose(),
          ),
          Provider(
            create: (_) => SellerAddressService.create(),
            dispose: (_, value) => value.client.dispose(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
            unselectedWidgetColor: DBColors.GRAY_11,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English, no country code
            const Locale('es', 'ES'), // English, no country code
          ],
          title: 'DeBerrio',
          //home: IntroScreen()),
          initialRoute: prefs.screen == 0 ? 'onBoard' : 'home',
          routes: {
            //'home': (context) => LocationPage(),
            //'home': (context) => PhoneNumScreen(),
            'home': (context) => HomePage(),
            //'home': (context) => CalendarPage(),
            //'home': (context) => DishLocation(),
            //'home': (context) => PublishPage(),
            //'home': (context) => MenuPage(),
            //'home': (context) => SaleDetails(),
            //'home': (context) => RouteDeliveryPage(),
            //'home': (context) => SearchPage(),
            //'home': (context) => PurchasePage(),
            //'home': (context) => ShoppingCartHome(),
            //'home': (context) => ShoppingCartOrderPlacedSplash(),
            //'home': (context) => HomeFilter(),
            //'home': (context) => OrderDetailFinish(),
            //'home': (context) => OrderDetailOngoing(),
            //'home': (context) => ProfileHomePage(),
            'onBoard': (context) => IntroScreen(),
          },
          onGenerateRoute: Routes.sailor.generator(),
          navigatorKey: Routes.sailor.navigatorKey,
        ));
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
// TODO: you need to get user name and picture
// TODO: user picture and restaurant picture would be the same?
