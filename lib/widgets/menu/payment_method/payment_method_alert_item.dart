import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange_outline.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'payment_method_style.dart';

class PaymentMethodAlert extends StatelessWidget {
  const PaymentMethodAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            SvgPicture.asset(
              'assets/images/credit_card.svg',
              height: 68.0,
              width: 68.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '¡Hola!',
              style: titleAlert,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'De Barrio te recomienda utilizar \ntarjeta Visa o Mastercard.',
              style: subTitleAlert,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.0,
            ),
            Flexible(
              child: GenericButtonOrange(
                text: 'ACEPTAR',
                disable: false,
                action: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //FlutterLogo(size: 100.0),
          ],
        ),
      ),
    );
  }
}
