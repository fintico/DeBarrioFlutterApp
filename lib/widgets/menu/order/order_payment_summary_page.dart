import 'package:debarrioapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'order_style.dart';

class OrderPaymentSummary extends StatelessWidget {
  final int type;
  const OrderPaymentSummary({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    final appBar = PreferredSize(
      child: AppBarOptionSix(
        leftIconAction: () {
          Routes.sailor.navigate(
            type == 2
                ? Routes.ORDER_DETAIL_FINISH_SCREEN
                : Routes.ORDER_DETAIL_ONGOING_SCREEN,
            navigationType: NavigationType.pushReplace,
          );
        },
        headerTitle: 'Resumen del Pago',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 32.0),
                  child: Text(
                    'Subtotal comida',
                    style: titlePricePaymentSummaryStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 28.0, top: 32.0),
                  child: Text(
                    'S/ ${orderBloc.orderDetail.order.subtotalPrice}',
                    style: pricePaymentSummaryStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 16.0, bottom: 16.0),
                  child: Text(
                    'Propina',
                    style: titlePricePaymentSummaryStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 28.0, top: 16.0, bottom: 16.0),
                  child: Text(
                    'S/ ${orderBloc.orderDetail.order.tip}',
                    style: pricePaymentSummaryStyle,
                  ),
                ),
              ],
            ),
            Divider(
              color: DBColors.BLUE_LIGHT_5,
              thickness: 1.0,
              indent: 28.0,
              endIndent: 28.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                  child: Text(
                    'Total pagado',
                    style: totalPricePaymentSummaryStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 28.0, top: 16.0),
                  child: Text(
                    'S/ ${orderBloc.orderDetail.order.totalPrice}',
                    style: totalPricePaymentSummaryStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
