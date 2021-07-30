import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/providers/shopping_cart_provider.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'shopping_cart_style.dart';

class ShoppingCartTip extends StatelessWidget {
  const ShoppingCartTip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoppingCartBloc = Provider.of<ShoppingCartBloc>(context);
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: DBColors.GREEN_LIGHT,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 15.0, bottom: 15.0),
              child: Text(
                '¿Una propina?',
                style: tipTitleStyle,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, top: 6.0, bottom: 6.0),
                  child: InkWell(
                    onTap: () {
                      if (purchaseBloc.totalPriceOrder != 0.0) {
                        shoppingCartBloc.onTiped(1);
                        if (purchaseBloc.tip != 1) {
                          purchaseBloc.onTip(1);
                        } else {
                          shoppingCartBloc.onTiped(0);
                          purchaseBloc.onTip(0);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shoppingCartBloc.tiped == 1
                            ? DBColors.GREEN_DARK
                            : DBColors.GREEN,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 11.0),
                        child: Text(
                          'S/ 1',
                          style: shoppingCartBloc.tiped == 1
                              ? tipNumberTapedTitleStyle
                              : tipNumberTitleStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 6.0, bottom: 6.0),
                  child: InkWell(
                    onTap: () {
                      if (purchaseBloc.totalPriceOrder != 0.0) {
                        shoppingCartBloc.onTiped(2);
                        if (purchaseBloc.tip != 2) {
                          purchaseBloc.onTip(2);
                        } else {
                          shoppingCartBloc.onTiped(0);
                          purchaseBloc.onTip(0);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shoppingCartBloc.tiped == 2
                            ? DBColors.GREEN_DARK
                            : DBColors.GREEN,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 11.0),
                        child: Text(
                          'S/ 2',
                          style: shoppingCartBloc.tiped == 2
                              ? tipNumberTapedTitleStyle
                              : tipNumberTitleStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 6.0, bottom: 6.0),
                  child: InkWell(
                    onTap: () {
                      if (purchaseBloc.totalPriceOrder != 0.0) {
                        shoppingCartBloc.onTiped(3);
                        if (purchaseBloc.tip != 3) {
                          purchaseBloc.onTip(3);
                        } else {
                          shoppingCartBloc.onTiped(0);
                          purchaseBloc.onTip(0);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shoppingCartBloc.tiped == 3
                            ? DBColors.GREEN_DARK
                            : DBColors.GREEN,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 11.0),
                        child: Text(
                          'S/ 3',
                          style: shoppingCartBloc.tiped == 3
                              ? tipNumberTapedTitleStyle
                              : tipNumberTitleStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 6.0, bottom: 6.0, right: 16.0),
                  child: InkWell(
                    onTap: () {
                      if (purchaseBloc.totalPriceOrder != 0.0) {
                        shoppingCartBloc.onTiped(5);
                        if (purchaseBloc.tip != 5) {
                          purchaseBloc.onTip(5);
                        } else {
                          shoppingCartBloc.onTiped(0);
                          purchaseBloc.onTip(0);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: shoppingCartBloc.tiped == 5
                            ? DBColors.GREEN_DARK
                            : DBColors.GREEN,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 11.0),
                        child: Text(
                          'S/ 5',
                          style: shoppingCartBloc.tiped == 5
                              ? tipNumberTapedTitleStyle
                              : tipNumberTitleStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
