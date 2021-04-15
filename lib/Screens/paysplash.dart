import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'map_screen.dart';

class PaySplash extends StatefulWidget {
  @override
  _PaySplashState createState() => _PaySplashState();
}

class _PaySplashState extends State<PaySplash> {
  @override
  Widget build(BuildContext context) {
    /* final appBar = AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.black87,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage("assets/images/Logo.png"),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    ); */
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
                    //height: 120.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    /* child: Image(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      image: AssetImage("assets/images/shop_bag.png"),
                      fit: BoxFit.contain,
                    ), */
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/shop_bag.svg',
                        height: 88.0,
                        width: 88.0,
                      ),
                    ),
                  ),
                  /*  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ), */
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Text(
                      "No tienes platos en" "\ntu carrito",
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
                      "Busca y elige entre la variedad de\n ofertas de tu barrio",
                      //textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: DBStyles.FONT_SYZE_L,
                        fontWeight: DBStyles.FONT_WEIGHT_REGULAR,
                        fontFamily: DBStyles.FONT_FAMILY,
                        color: DBColors.WHITE,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  /* Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ), */
                  SizedBox(
                    height: 120,
                  ),
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RaisedButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => MapScreen()),
                                (Route<dynamic> route) => false)
                          },
                          child: Text(
                            "Buscar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), */
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: GenericButtonOrange(
                        text: 'VOLVER',
                        disable: false,
                        action: () => Navigator.pop(context)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
