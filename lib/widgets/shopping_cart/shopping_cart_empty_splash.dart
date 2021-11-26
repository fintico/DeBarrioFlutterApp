import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';

import 'shopping_cart_style.dart';

class ShoppingCartEmptySplash extends StatelessWidget {
  const ShoppingCartEmptySplash({Key? key}) : super(key: key);

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
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.0,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/shop_bag.svg',
                          height: 88.0,
                          width: 88.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: Text(
                      "No tienes platos en" "\ntu carrito",
                      textAlign: TextAlign.center,
                      style: titleEmptySplash,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Busca y elige entre la variedad de\n ofertas de tu barrio.",
                      textAlign: TextAlign.center,
                      style: subtitleEmptySplash,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 3.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.0),
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
