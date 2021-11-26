import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/icons/close.dart';
import 'package:debarrioapp/widgets/components/app_bar.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionSeven extends StatelessWidget {
  final VoidCallback? leftIconAction;
  final String? title;
  const AppBarOptionSeven({
    Key? key,
    @required this.leftIconAction,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: true,
          headerBackground: DBColors.BLACK,
          headerLogo: true,
          circularBorder: false,
          subTitle: '',
          title: title,
          headerTitle: '',
          leftIconAction: leftIconAction,
          leftIcon: CloseIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ),
        ),
      ),
    );
  }
}
