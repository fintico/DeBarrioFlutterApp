import 'dart:developer';

import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../../utilsFunctions.dart';
import 'order_style.dart';

class OrderCard extends StatelessWidget {
  final OrderDetail? orderDetail;
  const OrderCard({Key? key, this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Container(
      color: DBColors.WHITE,
      child: InkWell(
        onTap: () {
          //inspect(orderDetail);
          orderBloc.setOrder(orderDetail!);
          //print(orderBloc.order.id);
          Routes.sailor.navigate(
            orderDetail!.order!.state == 4
                ? Routes.ORDER_DETAIL_FINISH_SCREEN
                : Routes.ORDER_DETAIL_ONGOING_SCREEN,
            navigationType: NavigationType.pushReplace,
            params: {
              'orderDetail': orderDetail,
            },
          );
        },
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 22.0, left: 28.0, right: 28.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //"PUBLICACIÓN #0${dishProvider.list[index].id}",
                      "ORDEN #0${orderDetail!.order!.id}",
                      style: numberOrdersStyle,
                    ),
                    orderDetail!.order!.state == 4
                        ? stateOffBox()
                        : stateOnBox()
                    //stateOffBox()
                    //getDishState(dishProvider.list[index])
                    /* getDishState(dish) && dish.isActive
                              ? stateOnBox()
                              : stateOffBox(), */
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 18.0, bottom: 40.0),
                  child: cZeroStr(orderDetail!.dish!.image)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image(
                            image: NetworkImage(
                                //dishProvider.list[index].image),
                                orderDetail!.dish!.image!),
                            height: 56.0,
                            width: 56.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: SvgPicture.asset(
                            'assets/images/empty.svg',
                            height: 46.0,
                            width: 46.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 18.0),
                        child: Text(
                          //dishProvider.list[index].dishName,
                          orderDetail!.dish!.dishName!,
                          style: titleCardStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                        child: Text(
                          /*  dishProvider.list[index].deliveryDate +
                                    dishProvider.list[index].deliveryTimeFrom +
                                    dishProvider.list[index].deliveryTimeTo, */
                          //'Entrega ${dateTimeString(dishProvider.list[index])}',
                          'Entrega ${dateSaleTimeString(orderDetail!.dish!, orderDetail!.order!)}',
                          style: subtitleCardStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 4.0, bottom: 24.0),
                        child: Text(
                          //'S/ ${dishProvider.list[index].priceDelivery}'
                          '${pluralPortion(orderDetail!.order!.portion!)} | S/ ${orderDetail!.order!.totalPrice}'
                              .toString(),
                          style: priceCardStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 48.0, left: 46.0, right: 0.0, bottom: 50.0),
                  child: AngleRightIcon(
                    height: 24.0,
                    width: 24.0,
                    color: DBColors.GRAY_2,
                  ),
                )
              ],
            ),
            Divider(
              color: DBColors.GRAY_12,
              indent: 28.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget stateOnBox() {
    return Container(
      decoration: BoxDecoration(
        color: DBColors.GREEN_LIGHT,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 4.0, top: 7.0, bottom: 7.0),
            child: Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: DBColors.GREEN,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 8.0),
            child: Text(
              'EN CURSO'
              /* state == 1
                  ? 'EN CURSO'
                  : state == 2
                      ? 'CONFIRMADA'
                      : state == 3
                          ? 'PREPARADA'
                          : null */
              ,
              style: stateOnStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget stateOffBox() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        width: 86.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: DBColors.GRAY_15,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: DBColors.GRAY_2,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Text(
              'FINALIZADA',
              style: stateOFFStyle,
            ),
          ],
        ),
      ),
    );
  }
}
