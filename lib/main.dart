import 'package:da_brello_ui/ModelClass/OrderModel.dart';
import 'package:da_brello_ui/ModelClass/PostedDishModel.dart';
import 'package:intl/date_symbol_data_local.dart' as symbolLocal;
import 'ModelClass/foodData.dart';
import 'ModelClass/orderList.dart';
import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Services/FirebaseAuthService.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/splash_screen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  AuthService authService;
  DatabaseService database;
  @override
  Widget build(BuildContext context) {
    symbolLocal.initializeDateFormatting('es');
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
          title: 'DeBerrio',
          home: Splash()),
    );
  }

}


// TODO: you need to get user name and picture
// TODO: user picture and restaurant picture would be the same?