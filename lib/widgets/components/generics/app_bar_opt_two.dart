import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/widgets/components/icons/shop_cart.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionTwo extends StatelessWidget {
  final VoidCallback? leftIconAction;
  //final Function rightIconAction;
  final String? title;
  const AppBarOptionTwo(
      {Key? key,
      @required this.leftIconAction,
      //@required this.rightIconAction,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: false,
          headerBackground: DBColors.BLACK,
          headerLogo: true,
          circularBorder: true,
          headerTitle: '',
          title: title,
          subTitle: '',
          subTitleIconAction: () {},
          subTitleIcon: Container(),
          leftIconAction: () {},
          leftIcon: AngleLeftIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ),
          //rightIconAction: rightIconAction,
          /* rightIcon: ShopCartIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ), */
          secondaryIcon: Container(),
          secondaryIconAction: () {},
        ),
      ),
    );
  }
}
