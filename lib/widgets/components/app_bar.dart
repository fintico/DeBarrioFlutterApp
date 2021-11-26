import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/widgets/components/icons/header_logo.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

import 'package:debarrioapp/ModelClass/UserModel.dart';

class AppBarWidgetArgs extends BaseArguments {
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? secondaryIcon;
  final VoidCallback? leftIconAction;
  final VoidCallback? rightIconAction;
  final VoidCallback? secondaryIconAction;
  final String? headerTitle;
  final String? title;
  final String? subTitle;
  final Widget? subTitleIcon;
  final VoidCallback? subTitleIconAction;
  final Widget? extraIcon;
  final VoidCallback? extraActionIcon;
  final bool? circularBorder;
  final bool? headerLogo;
  final Color? headerTitleColor;
  final Color? headerBackground;
  final bool? profileLogo;

  AppBarWidgetArgs({
    this.extraIcon,
    this.extraActionIcon,
    this.subTitle,
    this.subTitleIcon,
    this.subTitleIconAction,
    this.leftIcon,
    this.rightIcon,
    this.secondaryIcon,
    this.leftIconAction,
    this.rightIconAction,
    this.secondaryIconAction,
    this.title,
    this.circularBorder,
    this.headerLogo,
    this.headerTitle,
    this.headerTitleColor,
    this.headerBackground,
    this.profileLogo,
  });
}

class AppBarWidget extends StatelessWidget {
  final AppBarWidgetArgs? args;
  const AppBarWidget({Key? key, @required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: args!.headerBackground,
        borderRadius: args!.circularBorder!
            ? BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              )
            : BorderRadius.zero,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: args!.leftIcon != null
                    ? GestureDetector(
                        child: args!.leftIcon,
                        onTap: args!.leftIconAction,
                      )
                    : Container(
                        width: 24.0,
                        height: 24.0,
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0, left: 28.0),
                child: args!.headerLogo!
                    ? HeaderLogoIcon(
                        height: 22.0,
                        width: 180.0,
                      )
                    : Text(
                        args!.headerTitle!,
                        textAlign: TextAlign.center,
                        style: DBStyles.getStyle(
                            args!.headerTitleColor!,
                            DBStyles.FONT_SYZE_L,
                            DBStyles.FONT_HEIGHT_L,
                            0,
                            DBStyles.FONT_WEIGHT_SEMI_BOLD),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Container(
                      child: args!.secondaryIcon != null
                          ? GestureDetector(
                              child: args!.secondaryIcon,
                              onTap: args!.secondaryIconAction,
                            )
                          : Container(),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, right: 16.0, left: 20.0),
                    child: Container(
                      child: args!.rightIcon != null
                          ? GestureDetector(
                              child: args!.rightIcon,
                              onTap: args!.rightIconAction,
                            )
                          : Container(
                              width: 24.0,
                              height: 24.0,
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            child: (args!.title!.isNotEmpty || args!.subTitle!.isNotEmpty)
                ? _getContent()
                : Container(
                    height: 12.0,
                  ),
          ),
          Container(
            child: args!.profileLogo!
                ? _getProfile(context)
                : Container(
                    height: 0.0,
                  ),
          )
        ],
      ),
    );
  }

  Widget _getContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
        Container(
          child: args!.title!.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 14.0, bottom: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        args!.title!,
                        textAlign: TextAlign.center,
                        style: DBStyles.getStyle(
                            DBStyles.YELLOW,
                            DBStyles.FONT_SYZE_L,
                            DBStyles.FONT_HEIGHT_L,
                            0,
                            DBStyles.FONT_WEIGHT_BOLD),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 14.0, bottom: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: args!.subTitleIconAction!,
                          child: args!.subTitleIcon,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          args!.subTitle!,
                          textAlign: TextAlign.center,
                          style: DBStyles.getStyle(
                              DBStyles.GREEN,
                              DBStyles.FONT_SYZE_S,
                              DBStyles.FONT_HEIGHT_S,
                              0,
                              DBStyles.FONT_WEIGHT_SEMI_BOLD),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Container(
                          child: GestureDetector(
                            onTap: args!.extraActionIcon,
                            child: args!.extraIcon,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        )
      ],
    );
  }

  Widget _getProfile(BuildContext context) {
    //User user;
    //user = Provider.of<User>(context);
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60.0,
            backgroundImage: cZeroStr(homeBloc.sellerAddress!.seller!.urlImage)
                ? NetworkImage(homeBloc.sellerAddress!.seller!.urlImage!)
                : null,
            child: cZeroStr(homeBloc.sellerAddress!.seller!.urlImage!)
                ? null
                : SvgPicture.asset(
                    'assets/images/user.svg',
                    height: 88.0,
                    width: 88.0,
                    fit: BoxFit.fitWidth,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            cZeroStr(homeBloc.sellerAddress!.seller!.user!.username)
                ? homeBloc.sellerAddress!.seller!.user!.username! ==
                        homeBloc.sellerAddress!.seller!.user!.phoneNumber!
                    ? 'No hay información'
                    : homeBloc.sellerAddress!.seller!.user!.username!
                : "No hay información",
            textAlign: TextAlign.center,
            style: DBStyles.getStyle(
              DBStyles.WHITE,
              DBStyles.FONT_SYZE_H3,
              DBStyles.FONT_HEIGHT_H3,
              0,
              DBStyles.FONT_WEIGHT_REGULAR,
            ),
          ),
        ),
      ],
    );
  }
}
