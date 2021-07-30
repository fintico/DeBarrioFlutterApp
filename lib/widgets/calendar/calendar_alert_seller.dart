import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailor/sailor.dart';

import 'calendar_style.dart';

class CalendarAlertSeller extends StatelessWidget {
  const CalendarAlertSeller({Key key}) : super(key: key);

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
              'assets/images/dish.svg',
              height: 68.0,
              width: 68.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '!Hola!',
              style: titleAlert,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'De Barrio te recomienda \n actualizar tu perfil para\n comenzar a vender.',
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
                action: () async {
                  Navigator.of(context).pop();
                  Routes.sailor.navigate(
                    Routes.PROFILE_HOME_SCREEN,
                    navigationType: NavigationType.pushReplace,
                  );
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Flexible(
              child: GenericButtonWhite(
                text: 'CANCELAR',
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
