import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionFive extends StatelessWidget {
  final Function leftIconAction;
  final String headerTitle;

  const AppBarOptionFive(
      {Key key, @required this.leftIconAction, @required this.headerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: false,
          headerBackground: DBColors.WHITE,
          circularBorder: false,
          headerLogo: false,
          title: '',
          subTitle: '',
          headerTitle: headerTitle,
          headerTitleColor: DBColors.GRAY_1,
          leftIconAction: leftIconAction,
          leftIcon: AngleLeftIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.GRAY_2,
          ),
        ),
      ),
    );
  }
}
