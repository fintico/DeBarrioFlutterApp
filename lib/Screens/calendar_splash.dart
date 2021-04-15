import 'package:debarrioapp/Screens/calender_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

class CalendarSplash extends StatefulWidget {
  CalendarSplash({Key key}) : super(key: key);

  @override
  _CalendarSplashState createState() => _CalendarSplashState();
}

class _CalendarSplashState extends State<CalendarSplash> {
  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: Container(
          child: AppBarOptionOne(
            leftIconAction: () => Navigator.pop(context),
          ),
        ),
        preferredSize: Size.fromHeight(52.0));
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.BLACK,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/calendar.svg',
                        height: 88.0,
                        width: 88.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Text(
                      "Bienvenido al" "\ncalendario",
                      //textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: DBStyles.FONT_SYZE_H2,
                          color: DBColors.YELLOW,
                          fontWeight: DBStyles.FONT_WEIGHT_BOLD,
                          fontFamily: DBStyles.FONT_FAMILY),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    child: Text(
                      "Aquí podrás comprar o vender tus\n platos de forma programada y\n sencilla en los dias que elijas.",
                      //textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: DBStyles.FONT_SYZE_L,
                        fontWeight: DBStyles.FONT_WEIGHT_REGULAR,
                        fontFamily: DBStyles.FONT_FAMILY,
                        color: DBColors.WHITE,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: GenericButtonOrange(
                      text: 'COMENZAR',
                      disable: false,
                      action: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CalendarTimeline()),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
