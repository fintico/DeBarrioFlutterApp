import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sailor/sailor.dart';

class ShoppingCartOrderPlacedSplash extends StatelessWidget {
  const ShoppingCartOrderPlacedSplash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
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
                        'assets/images/order_bag.svg',
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
                      "¡Buenazo!",
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
                      "Tu pedido ha sido realizado con\n éxito. El N° de orden es ${purchaseBloc.orderId}",
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
                  SizedBox(
                    height: 50,
                  ),

                  /* Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ), */
                  SizedBox(
                    height: 110,
                  ),
                  Container(
                    child: Text(
                      'Recuerda que puedes revisar el estado de tu\n pedido en la sección "Mis pedidos".',
                      //textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: DBStyles.FONT_SYZE_S,
                        fontWeight: DBStyles.FONT_WEIGHT_REGULAR,
                        fontFamily: DBStyles.FONT_FAMILY,
                        color: DBColors.GRAY_7,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 28.0),
                          child: GenericButtonWhite(
                            text: 'MIS PEDIDOS',
                            disable: false,
                            action: () => Routes.sailor.navigate(
                              Routes.ORDER_HOME_PAGE_SCREEN,
                              navigationType: NavigationType.pushReplace,
                              removeUntilPredicate: (route) => true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 32.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: GenericButtonOrange(
                            text: 'INICIO',
                            disable: false,
                            action: () => Routes.sailor.navigate(
                              Routes.HOME_SCREEN,
                              navigationType: NavigationType.pushReplace,
                              removeUntilPredicate: (route) => true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
    /*  return Container(
      child: Center(
          child: TextButton(
        onPressed: () {
          Routes.sailor.navigate(
            Routes.HOME_SCREEN,
            navigationType: NavigationType.pushReplace,
            removeUntilPredicate: (route) => true,
          );
        },
        child: Text(
          'Pedido Realizado',
          style: TextStyle(color: Colors.white),
        ),
      )),
    ); */
  }
}
