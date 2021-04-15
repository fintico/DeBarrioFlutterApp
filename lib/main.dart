import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/Screens/Registration/OnBoardingScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart' as symbolLocal;
import 'package:intl/intl.dart';
import 'ModelClass/foodData.dart';
import 'ModelClass/orderList.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Services/FirebaseAuthService.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'Screens/splash_screen.dart';

void main() => runApp(new MyApp());

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
        ChangeNotifierProvider(create: (BuildContext context) => PostedDish()),
        ChangeNotifierProvider(create: (BuildContext context) => Order()),
        ChangeNotifierProvider(create: (BuildContext context) => FoodData()),
        ChangeNotifierProvider(create: (BuildContext context) => OrderList()),
      ],
      child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.green),
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
          home: Splash()),
    );
  }
}

// TODO: you need to get user name and picture
// TODO: user picture and restaurant picture would be the same?
