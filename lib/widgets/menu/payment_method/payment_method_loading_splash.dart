import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class CreditCardAddSplash extends StatelessWidget {
  final CreditCardModel? creditCard;
  const CreditCardAddSplash({Key? key, this.creditCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addCreditCard(context);
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
                  'Estamos agregando \n tu tarjeta...',
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

  Future addCreditCard(BuildContext context) async {
    final paymentMethodBloc =
        Provider.of<PaymentMethodBloc>(context, listen: false);
    final prefs = new UserPreferences();
    try {
      await Provider.of<PaymentService>(context).postCreditCardCreate(
        creditCard!.cardNumber,
        creditCard!.cardHolderName,
        creditCard!.expiryDate,
        creditCard!.cvvCode,
        false,
        int.parse(creditCard!.brand),
        prefs.userId,
      );
      await Future.delayed(Duration(milliseconds: 200));
      paymentMethodBloc.isPaying == true
          ? Routes.sailor.navigate(
              Routes.PAYMENT_METHOD_LIST_SCREEN,
              navigationType: NavigationType.pushReplace,
              removeUntilPredicate: (route) => true,
              params: {
                'isCreated': true,
              },
            )
          : Routes.sailor.navigate(
              Routes.PAYMENT_METHOD_PAY_SCREEN,
              navigationType: NavigationType.pushReplace,
            );
    } catch (e) {
      print(e);
    }
  }
}
