import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/providers/shopping_cart_provider.dart';
import 'package:debarrioapp/widgets/components/icons/trash.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_card_item.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_tip_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'shopping_cart_bottom_item.dart';
import 'shopping_cart_style.dart';

class ShoppingCartHome extends StatelessWidget {
  const ShoppingCartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    final shoppingCartBloc = Provider.of<ShoppingCartBloc>(context);
    final appBar = PreferredSize(
        child: AppBarOptionSix(
            leftIconAction: () =>
                /* Routes.sailor.navigate(
                  Routes.HOME_SCREEN,
                  navigationType: NavigationType.push,
                ), */
                Navigator.pop(context),
            headerTitle: 'Carrito de compras'),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, top: 32.0, bottom: 16.0),
                  child: Text(
                    purchaseBloc.restaurantName.toUpperCase(),
                    style: titleHeaderStyle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: purchaseBloc.orderDetails.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.15,
                        child: ShoppingCartCard(
                          index: index,
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            color: DBColors.RED,
                            iconWidget: TrashIcon(
                                height: 24.0,
                                width: 24.0,
                                color: DBColors.WHITE),
                            onTap: () {
                              print('elimiar item $index');
                              purchaseBloc.removeOrder(index);
                              if (purchaseBloc.orderDetails.length == 0) {
                                purchaseBloc.removeAllOrder();
                                shoppingCartBloc.onTiped(0);
                                purchaseBloc.onTip(0);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                )
                //ShoppingCartCard(),
              ],
            ),
            Positioned(
                bottom: 20.0, right: 5.0, left: 5.0, child: ShoppingCartTip()),
          ],
        ),
        bottomNavigationBar: ShoppingCartBottom(),
      ),
    );
  }
}
