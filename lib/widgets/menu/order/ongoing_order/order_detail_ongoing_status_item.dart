import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/widgets/menu/order/order_style.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/check_circle_off.dart';
import 'package:debarrioapp/widgets/components/icons/check_circle_on.dart';
import 'package:debarrioapp/widgets/components/icons/status_line.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'order_ongoing_style.dart';

class OrderDetailOngingStatus extends StatelessWidget {
  const OrderDetailOngingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, top: 24.0, bottom: 24.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleCheckOnIcon(height: 24.0, width: 24.0),
                  StatusLineIcon(
                      height: 38.0, width: 38.0, color: DBColors.GREEN),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Orden recibida',
                  style: titleStatusOnOrderOngoingStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  orderBloc.orderDetail!.order!.state! >= 2
                      ? CircleCheckOnIcon(height: 24.0, width: 24.0)
                      : CircleCheckOffIcon(height: 24.0, width: 24.0),
                  StatusLineIcon(
                    height: 38.0,
                    width: 38.0,
                    color: orderBloc.orderDetail!.order!.state! >= 2
                        ? DBColors.GREEN
                        : DBColors.GRAY_7,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Orden confirmada',
                  style: orderBloc.orderDetail!.order!.state! >= 2
                      ? titleStatusOnOrderOngoingStyle
                      : titleStatusOffOrderOngoingStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  orderBloc.orderDetail!.order!.state! >= 3
                      ? CircleCheckOnIcon(height: 24.0, width: 24.0)
                      : CircleCheckOffIcon(height: 24.0, width: 24.0),
                  StatusLineIcon(
                    height: 38.0,
                    width: 38.0,
                    color: orderBloc.orderDetail!.order!.state! >= 3
                        ? DBColors.GREEN
                        : DBColors.GRAY_7,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Orden preparada',
                  style: orderBloc.orderDetail!.order!.state! >= 3
                      ? titleStatusOnOrderOngoingStyle
                      : titleStatusOffOrderOngoingStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              orderBloc.orderDetail!.order!.state! >= 4
                  ? CircleCheckOnIcon(height: 24.0, width: 24.0)
                  : CircleCheckOffIcon(height: 24.0, width: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Orden entregada',
                  style: orderBloc.orderDetail!.order!.state! >= 4
                      ? titleStatusOnOrderOngoingStyle
                      : titleStatusOffOrderOngoingStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
