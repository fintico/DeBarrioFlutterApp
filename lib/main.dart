import 'package:debarrioapp/Screens/Registration/OnBoardingScreen.dart';
import 'package:debarrioapp/Services/order_service.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/providers/register_provider.dart';
import 'package:debarrioapp/providers/sale_provider.dart';
import 'package:debarrioapp/providers/search_provider.dart';
import 'package:debarrioapp/providers/shopping_cart_provider.dart';
import 'package:debarrioapp/providers/user_provider.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/providers/location_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:debarrioapp/widgets/calendar/calendar_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:debarrioapp/ServicesFire/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

import 'widgets/home/home_page.dart';

int? initScreen;

Future<void> main() async {
  Routes.createRoutes();
  setupLocator();
  //_setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  late final AuthService authService;
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
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
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RegisterProvider()),
          /* Provider(
            create: (_) => RegisterService.create(),
            dispose: (_, value) => value!.client.dispose(),
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
          ) */
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
          initialRoute: prefs.screen == 0 ? 'onBoard' : 'home',
          routes: {
            'home': (context) => HomePage(),
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
