import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'shopping_cart_style.dart';

class ShoppingCartBottom extends StatelessWidget {
  const ShoppingCartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return Container(
      height: screenHeight(context, dividedBy: 5.4),
      decoration: BoxDecoration(
        color: DBColors.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: DBColors.GRAY_14.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 8.0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 28.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: totalTextStyle,
                  ),
                  TextSpan(
                    text:
                        'S/ ${purchaseBloc.totalPriceOrder.toStringAsFixed(2)}',
                    style: priceTextStyle,
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 20.0, right: 28.0, top: 16.0, bottom: 28.0),
            child: GenericButtonOrange(
              text: 'IR A PAGAR',
              disable: false,
              action: () {
                print('pagar');
                Routes.sailor.navigate(
                  Routes.PAYMENT_METHOD_PAY_SCREEN,
                  navigationType: NavigationType.pushReplace,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
