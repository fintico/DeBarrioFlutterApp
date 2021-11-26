import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange_outline.dart';
import 'package:flutter/material.dart';

class OrderDetailFinishBottom extends StatelessWidget {
  const OrderDetailFinishBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: screenHeight(context, dividedBy: 5.4),
      padding: const EdgeInsets.only(
          left: 28.0, top: 20.0, right: 28.0, bottom: 24.0),
      child: GenericButtonOrangeOutline(
        text: 'REPETIR PEDIDO',
        disable: false,
        action: () {
          print('repetir');
          /* Routes.sailor.navigate(
                  Routes.PAYMENT_METHOD_PAY_SCREEN,
                  navigationType: NavigationType.pushReplace,
                ); */
        },
      ),
    );
  }
}
