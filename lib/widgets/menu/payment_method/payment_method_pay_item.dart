import 'package:debarrioapp/models/credit_card.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/components/icons/menu.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/components/icons/radio_inactive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:debarrioapp/widgets/components/icons/trash.dart';
import 'package:debarrioapp/widgets/components/icons/options_horizontal.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'payment_method_style.dart';

class PaymentMethodPayItem extends StatelessWidget {
  final CreditCard? creditCard;
  const PaymentMethodPayItem({Key? key, this.creditCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethodBloc = Provider.of<PaymentMethodBloc>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 20.0, bottom: 20.0),
                      child: SvgPicture.asset(
                        creditCard!.cardType!.id == 1
                            ? 'assets/images/visa.svg'
                            : 'assets/images/mastercard.svg',
                        height: 24.0,
                        width: 40.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 20.0, bottom: 20.0),
                      child: Text(
                        '**** ${creditCard!.cardNumber!.substring(creditCard!.cardNumber!.length - 5)}',
                        style: numberStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 28.0, top: 22.0, bottom: 22.0),
                  child: paymentMethodBloc.id == creditCard!.id
                      ? RadioActiveIcon(
                          height: 20.0,
                          width: 20.0,
                        )
                      : RadioInactiveIcon(
                          height: 20.0,
                          width: 20.0,
                          color: DBColors.GRAY_11,
                        ),
                )
              ],
            ),
            Divider(
              color: DBColors.BLUE_LIGHT_5,
              thickness: 1.0,
              indent: 28.0,
              endIndent: 28.0,
            ),
          ],
        ));
  }

  /* Future deletedCreditCard(BuildContext context) async {
    try {
      await Provider.of<PaymentService>(context, listen: false)
          .putUpdateStateByCreditCard(creditCard.id, true);
      Routes.sailor.navigate(
        Routes.PAYMENT_METHOD_LIST_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
        params: {
          'isCreated': false,
        },
      );
    } catch (e) {
      print(e);
    }
  } */
}
