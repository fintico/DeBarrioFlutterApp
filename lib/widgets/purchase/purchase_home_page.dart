import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_home_page.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/purchase/purchase_body_item.dart';
import 'package:debarrioapp/widgets/purchase/purchase_bottom_item.dart';
import 'package:debarrioapp/widgets/purchase/purchase_header_item.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one_v2.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class PurchasePage extends StatefulWidget {
  //final SellerDish sellerDish;
  final SellerDetail? sellerDish;
  PurchasePage({Key? key, this.sellerDish}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    final appBar = PreferredSize(
      child: AppBarOptionOneTwo(
          leftIconAction: () {
            Routes.sailor.navigate(
              Routes.HOME_SCREEN,
              navigationType: NavigationType.pushReplace,
              removeUntilPredicate: (route) => true,
            );
          },
          rightIconAction: () {
            if (purchaseBloc.orderDetails.length == 0) {
              Routes.sailor.navigate(
                Routes.SPLASH_EMPTY_CART_SCREEN,
                navigationType: NavigationType.push,
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShoppingCartHome(),
                ),
              );
            }
          },
          secondaryIconAction: () {}),
      preferredSize: Size.fromHeight(56.0),
    );
    //print('purchase ${widget.sellerDish.restaurantName}');
    //purchaseBloc.
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: Column(
            children: <Widget>[
              PurchaseHeader(
                sellerDish: widget.sellerDish,
              ),
              Expanded(
                child: PurchaseBody(sellerDish: widget.sellerDish),
              ),
            ],
          ),
        ),
        bottomNavigationBar: PurchaseBottom(),
      ),
    );
  }
}
