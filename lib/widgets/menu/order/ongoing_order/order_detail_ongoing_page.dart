import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_eight.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_body.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_header.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class OrderDetailOngoing extends StatelessWidget {
  const OrderDetailOngoing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionEight(
          leftIconAction: () {
            Routes.sailor.navigate(Routes.ORDER_HOME_PAGE_SCREEN,
                navigationType: NavigationType.pushReplace);
          },
          headerTitle: 'Detalle de la orden',
          rightIconAction: () => {/* detailsBottomSheet(context) */}),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            OrderDetailOngoingHeader(),
            OrderDetailOngoingBody(),
          ],
        ),
      ),
    );
  }
}
