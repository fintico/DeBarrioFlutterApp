import 'dart:convert';

import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_add_notify.dart';
import 'package:debarrioapp/widgets/menu/payment_method/payment_method_item_page.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/payment_service.dart';
import 'package:debarrioapp/models/credit_card.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'payment_method_style.dart';

class PaymentMethodPage extends StatelessWidget {
  final bool isCreated;
  const PaymentMethodPage({Key key, this.isCreated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionSix(
          leftIconAction: () => Routes.sailor.navigate(
                Routes.MENU_SCREEN,
                navigationType: NavigationType.pushReplace,
                transitions: [
                  SailorTransition.fade_in,
                  SailorTransition.slide_from_left,
                ],
              ),
          headerTitle: 'Métodos de pago'),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: _buildBody(context),
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
    return Container(
      height: screenHeight(context),
      color: DBColors.WHITE,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16.0),
          Flexible(
            child: ListView.builder(
              itemCount: creditCard.length,
              itemBuilder: (BuildContext context, int index) {
                return PaymentMethodItem(
                  creditCard: creditCard[index],
                );
              },
            ),
          ),
          /* Flexible(
            child: */
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Routes.sailor.navigate(
                      Routes.PAYMENT_METHOD_ADD_CARD_SCREEN,
                      navigationType: NavigationType.pushReplace,
                      transitions: [
                        SailorTransition.fade_in,
                        SailorTransition.slide_from_right
                      ],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                    child: PlusCircleIcon(
                      height: 16.0,
                      width: 16.0,
                      color: DBColors.GREEN,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Routes.sailor.navigate(
                      Routes.PAYMENT_METHOD_ADD_CARD_SCREEN,
                      navigationType: NavigationType.pushReplace,
                      transitions: [
                        SailorTransition.fade_in,
                        SailorTransition.slide_from_right
                      ],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 16.0),
                    child: Text(
                      'AGREGAR MÉTODO DE COBRO',
                      style: addPaymentMethodStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
            child: isCreated
                ? AddNotify(isCreated: isCreated)
                : SizedBox(
                    height: 0.1,
                  ),
          )
        ],
      ),
    );
  }
}
