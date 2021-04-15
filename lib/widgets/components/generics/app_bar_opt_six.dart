import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionSix extends StatelessWidget {
  final Function leftIconAction;
  final String headerTitle;
  const AppBarOptionSix({Key key, this.leftIconAction, this.headerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: false,
          headerBackground: DBColors.BLACK,
          circularBorder: true,
          headerLogo: false,
          title: '',
          subTitle: '',
          headerTitle: headerTitle,
          headerTitleColor: DBColors.YELLOW,
          leftIconAction: leftIconAction,
          leftIcon: AngleLeftIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ),
        ),
      ),
    );
  }
}
