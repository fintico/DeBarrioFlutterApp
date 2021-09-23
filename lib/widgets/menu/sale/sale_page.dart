import 'dart:convert';

import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/services/order_service.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_card_item.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'sale_style.dart';

class SalePage extends StatelessWidget {
  const SalePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: AppBarOptionSix(
            leftIconAction: () => Routes.sailor.navigate(Routes.MENU_SCREEN,
                    navigationType: NavigationType.pushReplace,
                    transitions: [
                      SailorTransition.fade_in,
                      SailorTransition.slide_from_left
                    ]),
            headerTitle: 'Mis ventas'),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: _buildBody(context),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    final prefs = new UserPreferences();
    return FutureBuilder(
      future:
          Provider.of<OrderService>(context).ordersDetailbySeller(prefs.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          final List<OrderDetail> ordersDetail =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => OrderDetail.fromJson(e))
                  .toList();
          return _buildOrders(context, ordersDetail);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildOrders(BuildContext context, List<OrderDetail> ordersDetail) {
    return Container(
      color: DBColors.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 32.0, bottom: 14.0),
            child: Text(
              '${ordersDetail.length} órdenes por entregar',
              style: saleTitlesStyle,
            ),
          ),
          Divider(
            color: DBColors.GRAY_12,
            indent: 28.0,
            endIndent: 28.0,
            thickness: 1.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ordersDetail.length,
              itemBuilder: (BuildContext context, int index) {
                return SaleCard(
                  orderDetail: ordersDetail[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
