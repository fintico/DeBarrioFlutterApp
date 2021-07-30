import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class FilterBottom extends StatelessWidget {
  const FilterBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    return Container(
      height: screenHeight(context, dividedBy: 3.85),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 29.0),
            child: GenericButtonOrange(
                text: 'APLICAR',
                disable: false,
                action: () {
                  print('aplicar');
                  _getRestaurantsFilter(context);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, right: 28.0, top: 16.0, bottom: 56.0),
            child: GenericButtonWhite(
                text: 'LIMPIAR FILTROS',
                disable: false,
                action: () {
                  homeBloc.removeAll();
                }),
          ),
        ],
      ),
    );
  }

  Future _getRestaurantsFilter(BuildContext context) async {
    try {
      final homeBloc = Provider.of<HomeBloc>(context, listen: false);
      DateTime today = DateTime.now().subtract(Duration(hours: 5));
      final formatterTo = new DateFormat('yyyy-MM-dd');
      String deliveryDate = formatterTo.format(today);
      /* Response<dynamic> res =
          await Provider.of<SellerService>(context, listen: false)
              .getDishesBySellerFilter(
                  homeBloc.dishStyle == 0 ? null : homeBloc.dishStyle,
                  homeBloc.deliveryDate ?? deliveryDate);
      homeBloc.sellers = (json.decode(res.bodyString) as List)
          .map((e) => SellerDish.fromJson(e))
          .toList(); */
      Response<dynamic> res =
          await Provider.of<SellerService>(context, listen: false)
              .getDishesBySellerFilter(
                  homeBloc.dishStyle == 0 ? null : homeBloc.dishStyle,
                  homeBloc.deliveryDate ?? deliveryDate);
      homeBloc.seller = (json.decode(res.bodyString) as List)
          .map((e) => SellerDetail.fromJson(e))
          .toList();

      //print(res.bodyString);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      /* Routes.sailor.navigate(
        Routes.HOME_SCREEN,
        navigationType: NavigationType.push,
        //removeUntilPredicate: (route) => true,
      ); */
      //print(homeBloc.deliveryDate);
    } catch (e) {
      print(e.toString());
    }
  }
}
