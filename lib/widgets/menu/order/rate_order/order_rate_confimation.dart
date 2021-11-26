import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'order_rate_style.dart';

class OrderRateConfirmation extends StatelessWidget {
  const OrderRateConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context, dividedBy: 3.0),
      child: Column(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              alignment: Alignment.topRight,
              child:
                  CrossIcon(height: 24.0, width: 24.0, color: DBColors.GRAY_2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21.0),
            child: RadioActiveIcon(height: 64.0, width: 64.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              '¡Gracias por tu calificación!',
              style: titleConfimationRateStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Nos ayudará a brindarte una mejor \n experiencia',
              style: subtitleConfimationRateStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
