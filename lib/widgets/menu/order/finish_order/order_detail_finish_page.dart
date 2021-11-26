import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/menu/order/finish_order/order_detail_finish_body.dart';
import 'package:debarrioapp/widgets/menu/order/finish_order/order_detail_finish_header.dart';
import 'package:debarrioapp/widgets/menu/order/rate_order/order_rate_notify_item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_eight.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'order_detail_finish_bottom.dart';

class OrderDetailFinish extends StatelessWidget {
  const OrderDetailFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    final appBar = PreferredSize(
        child: AppBarOptionEight(
            leftIconAction: () {
              Routes.sailor.navigate(Routes.ORDER_HOME_PAGE_SCREEN,
                  navigationType: NavigationType.pushReplace);
            },
            headerTitle: 'Detalle del pedido',
            rightIconAction: () => {/* detailsBottomSheet(context) */}),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                OrderDetailFinishHeader(),
                OrderDetailFinishBody(),
              ],
            ),
            Visibility(
              visible: !orderBloc.isGone,
              child: OrderDetailFinishNotifyItem(),
            ),
          ],
        )),
        bottomNavigationBar: OrderDetailFinishBottom(),
      ),
    );
  }
}
