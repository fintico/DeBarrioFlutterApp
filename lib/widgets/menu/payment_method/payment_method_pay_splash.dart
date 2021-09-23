import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/order.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/services/order_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class CreditCardPaySplash extends StatelessWidget {
  final CreditCardModel creditCard;
  const CreditCardPaySplash({Key key, this.creditCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addOrder(context);
    //addOrderDish(context);
    TextStyle title = DBStyles.getStyle(
      DBStyles.WHITE,
      DBStyles.FONT_SYZE_L,
      DBStyles.FONT_HEIGHT_L,
      0,
      DBStyles.FONT_WEIGHT_REGULAR,
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: screenHeight(context),
          decoration: BoxDecoration(color: DBColors.BLACK),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  child: SvgPicture.asset(
                    'assets/icons/loading.svg',
                    height: 124,
                    width: 224,
                    color: DBColors.WHITE,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Estamos procesando \n tu pago...',
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addOrder(BuildContext context) async {
    final purchaseBloc = Provider.of<PurchaseBloc>(context, listen: false);
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    final paymentMethodBloc =
        Provider.of<PaymentMethodBloc>(context, listen: false);
    DateTime today = DateTime.now().subtract(Duration(hours: 5));
    final formatterTo = new DateFormat('yyyy-MM-dd');
    String deliveryDate = formatterTo.format(today);
    try {
      for (var i = 0; i < purchaseBloc.orderDetails.length; i++) {
        Response<dynamic> res =
            await Provider.of<OrderService>(context, listen: false).postOrder(
          purchaseBloc.orderDetails[i].order.isDelivery,
          purchaseBloc.orderDetails[i].order.isPickup,
          purchaseBloc.orderDetails[i].order.totalPrice,
          purchaseBloc.orderDetails[i].order.subtotalPrice,
          purchaseBloc.tip.toDouble(),
          1,
          purchaseBloc.orderDetails[i].order.portion,
          purchaseBloc.orderDetails[i].order.deliveryDate == null
              ? deliveryDate
              : purchaseBloc.orderDetails[i].order.deliveryDate,
          null,
          true,
          false,
          homeBloc.customerAddress.id,
          paymentMethodBloc.id,
        );

        final orderJson = json.decode(res.bodyString).cast<String, dynamic>();
        Map<String, dynamic> order = new Map<String, dynamic>.from(orderJson);
        purchaseBloc.onOrder(order['id']);

        await Future.delayed(Duration(milliseconds: 100));
        await Provider.of<OrderService>(context, listen: false)
            .postOrderDish(purchaseBloc.orderId, purchaseBloc.dishId);
        await Future.delayed(Duration(milliseconds: 200));
      }

      /* Response<dynamic> res =
          await Provider.of<OrderService>(context).postOrder(
        purchaseBloc.delivery,
        purchaseBloc.pickup,
        purchaseBloc.totalPrice,
        purchaseBloc.subTotalPrice,
        purchaseBloc.tip.toDouble(),
        1,
        purchaseBloc.counter,
        purchaseBloc.deliveryDate == null
            ? deliveryDate
            : purchaseBloc.deliveryDate,
        null,
        true,
        false,
        homeBloc.customerAddress.id,
        paymentMethodBloc.id,
      ); */
      /* .postOrder(true, false, 15.20, 1, 1, '2021-06-18', true, false, 1); */
      /* final Order order =
          (json.decode(res.bodyString)).map((e) => Order.fromJson(e)).toList();
      print(order.id); */
      /* final orderJson = json.decode(res.bodyString).cast<String, dynamic>();
      Map<String, dynamic> order = new Map<String, dynamic>.from(orderJson);
      purchaseBloc.onOrder(order['id']);
      print(purchaseBloc.orderId);
      await Future.delayed(Duration(milliseconds: 100));
      await Provider.of<OrderService>(context, listen: false)
          .postOrderDish(purchaseBloc.orderId, purchaseBloc.dishId);
      await Future.delayed(Duration(milliseconds: 200)); */
      Routes.sailor.navigate(
        Routes.SPLASH_CONFIRM_ORDER_PLACED_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
      );
    } catch (e) {
      print(e);
    }
  }

  Future addOrderDish(BuildContext context) async {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    try {
      await Provider.of<OrderService>(context)
          .postOrderDish(purchaseBloc.orderId, purchaseBloc.dishId);
      await Future.delayed(Duration(milliseconds: 200));
      Routes.sailor.navigate(
        Routes.SPLASH_CONFIRM_ORDER_PLACED_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
      );
    } catch (e) {
      print(e);
    }
  }
}
