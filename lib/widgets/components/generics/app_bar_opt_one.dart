import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionOne extends StatelessWidget {
  final VoidCallback? leftIconAction;
  const AppBarOptionOne({Key? key, @required this.leftIconAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: false,
          headerBackground: DBColors.BLACK,
          headerLogo: true,
          circularBorder: false,
          rightIcon: Container(),
          rightIconAction: () {},
          secondaryIcon: Container(),
          secondaryIconAction: () {},
          subTitle: '',
          subTitleIcon: Container(),
          subTitleIconAction: () {},
          title: '',
          headerTitle: '',
          extraActionIcon: () {},
          extraIcon: Container(),
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
