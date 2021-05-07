import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/Screens/Registration/OnBoardingScreen.dart';
import 'package:debarrioapp/Services/dish_service.dart';
import 'package:debarrioapp/Services/location_service.dart';
import 'package:debarrioapp/Services/register_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart' as symbolLocal;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ModelClass/foodData.dart';
import 'ModelClass/orderList.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Services/FirebaseAuthService.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'Screens/Registration/phonenumber.dart';
import 'Screens/splash_screen.dart';
import 'widgets/home/home_page.dart';
import 'widgets/location/location_page.dart';
import 'widgets/registration/registration_page.dart';

int initScreen;

Future<void> main() async {
  Routes.createRoutes();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  AuthService authService;
  DatabaseService database;
  @override
  Widget build(BuildContext context) {
    //symbolLocal.initializeDateFormatting('es');
    // symbolLocal.initializeDateFormatting('es_US');
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => User()),
          ChangeNotifierProvider(
              create: (BuildContext context) => PostedDish()),
          ChangeNotifierProvider(create: (BuildContext context) => Order()),
          ChangeNotifierProvider(create: (BuildContext context) => FoodData()),
          ChangeNotifierProvider(create: (BuildContext context) => OrderList()),
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
          initialRoute:
              initScreen == 0 || initScreen == null ? 'onBoard' : 'home',
          routes: {
            'home': (context) => LocationPage(),
            'onBoard': (context) => IntroScreen(),
          },
          onGenerateRoute: Routes.sailor.generator(),
          navigatorKey: Routes.sailor.navigatorKey,
        ));
  }
}

// TODO: you need to get user name and picture
// TODO: user picture and restaurant picture would be the same?
