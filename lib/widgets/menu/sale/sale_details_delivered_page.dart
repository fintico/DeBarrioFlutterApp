import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/providers/sale_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/order_service.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/menu/sale/sale_delivery_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'sale_pickup_detail_item.dart';
import 'sale_style.dart';

class SaleDetailsDelivered extends StatelessWidget {
  final OrderDetail orderDetail;
  const SaleDetailsDelivered({Key key, this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saleBloc = Provider.of<SaleBloc>(context);
    final appBar = PreferredSize(
        child: AppBarOptionSix(
            leftIconAction: () => Routes.sailor.navigate(
                  Routes.SALE_LIST_SCREEN,
                  navigationType: NavigationType.push,
                ),
            headerTitle: 'Detalle de la orden'),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
          appBar: appBar,
          body: _buildBody(context),
          //bottomNavigationBar: _bottomNavOrder(context),
          bottomNavigationBar: Visibility(
            visible: saleBloc.isVisible,
            child: _bottomNavOrder(context),
            replacement: _notifyDone(saleBloc),
          )),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderService>(context, listen: false)
          .ordersDetailbyId(orderDetail.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          OrderDetail orderDetailDATA =
              OrderDetail.fromJson(json.decode(snapshot.data.bodyString));
          inspect(orderDetailDATA);
          if (orderDetail.order.isDelivery) {
            return _buildOrderDetailDelivery(context, orderDetailDATA);
          } else {
            return _buildOrderDetailPickup(context, orderDetailDATA);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildOrderDetailDelivery(
      BuildContext context, OrderDetail orderDetail) {
    return Container(
      child: DeliveryDetail(orderDetail: orderDetail),
    );
  }

  Widget _buildOrderDetailPickup(
      BuildContext context, OrderDetail orderDetail) {
    return Container(
      child: PickupDetail(orderDetail: orderDetail),
    );
  }

  _bottomNavOrder(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 24.0, left: 28.0, right: 28.0),
      child: GenericButtonOrange(
        text: 'ORDEN ENTREGADA',
        disable: false,
        action: () {
          _setStateOrder(context, orderDetail.order.id, 4);
        },
      ),
    );
  }

  _notifyDone(SaleBloc saleBloc) {
    return InkWell(
      onTap: () {
        saleBloc.onVisible();
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 24.0, left: 16.0, right: 16.0),
        child: Container(
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
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '¡Listo! ',
                            style: notifyTitleStyle,
                          ),
                          TextSpan(
                            text: 'La orden está preparada',
                            style: notifySubTitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                child: CrossIcon(
                  height: 16.0,
                  width: 16.0,
                  color: DBColors.GREEN,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _setStateOrder(BuildContext context, int orderId, int state) async {
    await Provider.of<OrderService>(context, listen: false)
        .updateOrderStateById(orderId, state);

    Routes.sailor.navigate(Routes.SALE_DETAILS_SCREEN,
        navigationType: NavigationType.pushReplace,
        params: {
          'orderDetail': orderDetail,
          'stateOrder': state,
        },
        transitions: [
          SailorTransition.fade_in,
          SailorTransition.slide_from_right
        ]);
  }
}
