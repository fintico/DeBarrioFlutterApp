import 'package:debarrioapp/widgets/components/icons/money.dart';
import 'package:debarrioapp/widgets/components/icons/shop_cart.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionOneTwo extends StatelessWidget {
  final Function leftIconAction;
  final Function rightIconAction;
  final Function secondaryIconAction;
  const AppBarOptionOneTwo({
    Key key,
    @required this.leftIconAction,
    @required this.rightIconAction,
    @required this.secondaryIconAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBarWidget(
        args: AppBarWidgetArgs(
          profileLogo: false,
          headerBackground: DBColors.BLACK,
          headerLogo: true,
          circularBorder: true,
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
          rightIconAction: rightIconAction,
          rightIcon: ShopCartIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ),
          secondaryIconAction: secondaryIconAction,
          secondaryIcon: MoneyIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.WHITE,
          ),
        ),
      ),
    );
  }
}
