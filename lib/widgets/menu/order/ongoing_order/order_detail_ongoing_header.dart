import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_route_item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'order_ongoing_style.dart';

class OrderDetailOngoingHeader extends StatelessWidget {
  const OrderDetailOngoingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 26.0, left: 28.0, bottom: 18.0),
                child: Text(
                  'ORDEN #0${orderBloc.orderDetail!.order!.id!}',
                  style: numberHeaderOrderOngoingStyle,
                ),
              ),
              stateOnBox(),
            ],
          ),
          OrderDetailOngoingRoute(),
          /* Container(
            width: double.infinity,
            height: screenHeight(context, dividedBy: 2.0),
            color: Colors.lightBlue,
          ) */
        ],
      ),
    );
  }

  Widget stateOnBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, right: 28.0, bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: DBColors.GREEN_LIGHT,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 4.0, top: 7.0, bottom: 7.0),
              child: Container(
                height: 6.0,
                width: 6.0,
                decoration: BoxDecoration(
                  color: DBColors.GREEN,
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 8.0),
              child: Text(
                'EN CURSO',
                style: stateOnHeaderOrderOngoingStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
