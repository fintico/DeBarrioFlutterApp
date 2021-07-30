import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/providers/payment_method_provider.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/models/credit_card.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'payment_method_pay_bottom.dart';
import 'payment_method_pay_item.dart';

class PaymentMethodPay extends StatelessWidget {
  const PaymentMethodPay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionSix(
          leftIconAction: () =>
              /* Routes.sailor.navigate(
                Routes.MENU_SCREEN,
                navigationType: NavigationType.pushReplace,
                transitions: [
                  SailorTransition.fade_in,
                  SailorTransition.slide_from_left,
                ],
              ), */
              Navigator.pop(context),
          headerTitle: 'Método de pago'),
      preferredSize: Size.fromHeight(56.0),
    );
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: appBar,
          body: _buildBody(context),
          bottomNavigationBar: PaymentMethodPayBottom(),
        ),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<PaymentService>(context).getCreditCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }

          final List<CreditCard> creditCard =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => CreditCard.fromJson(e))
                  .toList();
          /* paymentMethodBloc.creditCards =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => CreditCard.fromJson(e))
                  .toList(); */

          return _buildCreditCard(context, creditCard);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCreditCard(BuildContext context, List<CreditCard> creditCard) {
    final paymentMethodBloc = Provider.of<PaymentMethodBloc>(context);
    return Container(
      color: DBColors.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: creditCard.length,
              itemBuilder: (BuildContext context, int index) {
                //paymentMethodBloc.creditCards = creditCard;
                return InkWell(
                  onTap: () {
                    //paymentMethodBloc.onCreditCard(index);
                    paymentMethodBloc.onId(creditCard[index].id);
                  },
                  child: PaymentMethodPayItem(
                    creditCard: creditCard[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
