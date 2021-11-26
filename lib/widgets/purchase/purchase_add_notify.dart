import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_home_page.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'purchase_style.dart';

class PurchaseAddNotify extends StatefulWidget {
  const PurchaseAddNotify({
    Key? key,
    @required this.isCreated,
  }) : super(key: key);

  final bool? isCreated;

  @override
  _PurchaseAddNotifyState createState() => _PurchaseAddNotifyState();
}

class _PurchaseAddNotifyState extends State<PurchaseAddNotify> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return Container(
      decoration: BoxDecoration(
        color: DBColors.GREEN_LIGHT,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 16.0),
                child: RadioActiveIcon(
                  height: 20.0,
                  width: 20.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 12.0),
                child: Text(
                  'Agregado a tu carrito',
                  style: notifyTitleStyle,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
            child: InkWell(
              onTap: () {
                print('to car');
                /* Routes.sailor.navigate(
                  Routes.SHOPPING_CART_HOME_SCREEN,
                  navigationType: NavigationType.pushReplace,
                ); */
                purchaseBloc.onNotifyDisable();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ShoppingCartHome()));
              },
              child: Text(
                'Ver todo',
                style: notifySubTitleStyle,
              ),
            ),
          )
        ],
      ),
    );
    /* return AnimatedOpacity(
      duration: Duration(milliseconds: 600),
      opacity: opacity,
      child: InkWell(
        onTap: () {
          setState(() {
            opacity = (opacity == 1) ? 0 : 1;
          });
        },
        child: Container(
          //width: double.infinity,
          decoration: BoxDecoration(
            color: DBColors.GREEN_LIGHT,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, bottom: 14.0, left: 16.0),
                    child: RadioActiveIcon(
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 12.0),
                    child: Text(
                      'Agregado a tu carrito',
                      style: notifyTitleStyle,
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 16.0, right: 16.0),
                  child: Text(
                    'Ver todo',
                    style: notifySubTitleStyle,
                  ))
            ],
          ),
        ),
      ),
    ); */
  }
}
