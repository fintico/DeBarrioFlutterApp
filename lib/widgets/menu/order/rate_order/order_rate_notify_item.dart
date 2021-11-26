import 'package:debarrioapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'order_rate_style.dart';
import 'order_rate_bottom_sheet.dart';

class OrderDetailFinishNotifyItem extends StatelessWidget {
  const OrderDetailFinishNotifyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Container(
      color: DBColors.GRAY_6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 22.0, bottom: 22.0),
                child:
                    StarIcon(height: 20.0, width: 20.0, color: DBColors.YELLOW),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 20.0, bottom: 20.0),
                child: Text(
                  '¿Cómo te fue con tu pedido?',
                  style: titleNotifyRateStyle,
                ),
              ),
            ],
          ),
          Container(
            width: screenWidth(context, dividedBy: 3.5),
            padding:
                const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
            child: GenericButtonOrange(
              text: 'CALIFICAR',
              disable: false,
              action: () {
                print('calificar');
                orderBloc.onGone();
                rateBottomSheet(context);
              },
              height: 32.0,
            ),
          )
        ],
      ),
    );
  }

  void rateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      builder: (context) {
        return OrderRateBottomSheet();
      },
    );
  }
}
