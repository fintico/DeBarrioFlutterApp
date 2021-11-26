import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/widgets/components/icons/filter.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionFour extends StatelessWidget {
  final VoidCallback? leftIconAction;
  final VoidCallback? rightIconAction;
  final String? headerTitle;
  const AppBarOptionFour(
      {Key? key,
      @required this.leftIconAction,
      @required this.rightIconAction,
      @required this.headerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
            profileLogo: false,
            headerBackground: DBColors.BLACK,
            headerLogo: false,
            circularBorder: true,
            leftIconAction: leftIconAction,
            leftIcon: AngleLeftIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.WHITE,
            ),
            rightIconAction: rightIconAction,
            rightIcon: FilterIcon(
              height: 24.0,
              width: 24.0,
              type: 0,
              color: DBColors.WHITE,
            ),
            headerTitle: headerTitle,
            headerTitleColor: DBColors.YELLOW,
            title: '',
            subTitle: ''),
      ),
    );
  }
}
