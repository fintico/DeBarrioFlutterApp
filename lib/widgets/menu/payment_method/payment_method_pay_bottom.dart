import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/button_orange.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class PaymentMethodPayBottom extends StatelessWidget {
  const PaymentMethodPayBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 28.0),
      child: GenericButtonOrange(
          text: 'PAGAR S/ ${purchaseBloc.totalPriceOrder.toStringAsFixed(2)}',
          disable: false,
          action: () {
            Routes.sailor.navigate(
              Routes.SPLASH_PAY_CREDIT_CARD_SCREEN,
              navigationType: NavigationType.pushReplace,
            );
          }),
    );
  }
}
