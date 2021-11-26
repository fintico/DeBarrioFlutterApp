import 'package:debarrioapp/widgets/components/app_bar.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:debarrioapp/widgets/components/icons/menu.dart';
import 'package:debarrioapp/widgets/components/icons/money.dart';
import 'package:debarrioapp/widgets/components/icons/pointer.dart';
import 'package:debarrioapp/widgets/components/icons/shop_cart.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;

class AppBarOptionThree extends StatelessWidget {
  final VoidCallback? leftIconAction;
  final VoidCallback? rightIconAction;
  final VoidCallback? secondaryIconAction;
  final VoidCallback? subTitleIconAction;
  final String? subTitle;
  const AppBarOptionThree(
      {Key? key,
      @required this.leftIconAction,
      @required this.rightIconAction,
      @required this.secondaryIconAction,
      @required this.subTitleIconAction,
      @required this.subTitle})
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
          extraIcon: AngleDownIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.GREEN,
          ),
          extraActionIcon: () {},
          headerTitle: '',
          title: '',
          subTitle: subTitle,
          subTitleIconAction: subTitleIconAction,
          subTitleIcon: PointerIcon(
            height: 24.0,
            width: 24.0,
            color: DBColors.GREEN,
          ),
          leftIconAction: leftIconAction,
          leftIcon: MenuIcon(
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
