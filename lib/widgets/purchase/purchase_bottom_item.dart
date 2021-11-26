import 'dart:developer';

import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/order.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/minus.dart';
import 'package:debarrioapp/widgets/components/icons/plus.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'purchase_style.dart';

class PurchaseBottom extends StatelessWidget {
  //final OrderDetail orderDetail;
  const PurchaseBottom({Key? key /* , this.orderDetail */}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    final orderDetail = OrderDetail();
    final dish = DishModel();
    final order = Order();
    return Container(
      decoration: BoxDecoration(
        color: DBColors.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: DBColors.GRAY_14.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 8.0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 36.0, bottom: 36.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        print('menos');
                        print(purchaseBloc.counter);

                        purchaseBloc.onSubtract();
                      },
                      child: MinusIcon()),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(
                      purchaseBloc.counter.toString(),
                      style: numberBottomStyle,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        print('mas');
                        print(purchaseBloc.counter);
                        purchaseBloc.onCount();
                      },
                      child: PlusIcon()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 28.0, top: 28.0, bottom: 28.0),
              child: GenericButtonOrange(
                text:
                    'AGREGAR S/ ${purchaseBloc.totalPrice == null ? 0.0 : purchaseBloc.totalPrice.toStringAsFixed(2)}',
                disable: false,
                action: () {
                  print('agregar al carrito');
                  purchaseBloc.onNotify();
                  print(purchaseBloc.deliveryDate);
                  dish.id = purchaseBloc.dishId;
                  dish.dishName = purchaseBloc.dishName;
                  dish.image = purchaseBloc.dishImage;
                  //dish.seller.restaurantName = purchaseBloc.restaurantName;
                  order.subtotalPrice = purchaseBloc.subTotalPrice;
                  order.totalPrice = purchaseBloc.totalPrice;
                  order.isDelivery = purchaseBloc.delivery;
                  order.isPickup = purchaseBloc.pickup;
                  order.portion = purchaseBloc.counter;
                  order.deliveryDate = purchaseBloc.deliveryDate;
                  orderDetail.order = order;
                  orderDetail.dish = dish;

                  purchaseBloc.addOrder(orderDetail);
                  inspect(purchaseBloc.orderDetails);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
