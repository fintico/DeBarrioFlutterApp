import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/order.dart';
import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utilsFunctions.dart';
import 'sale_route_delivery_page.dart';
import 'sale_style.dart';

class DeliveryDetail extends StatelessWidget {
  final OrderDetail orderDetail;
  const DeliveryDetail({Key key, this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //child: Container(
      //child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 18.0),
                  child: Text(
                    /* "ORDEN #0${dish.id}", */
                    'ORDEN #0${orderDetail.order.id}',
                    style: numberOrdersPickupStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0, bottom: 16.0),
                  child: orderDetail.order.state == 4
                      ? stateOffBox()
                      : stateOnBox(orderDetail.order.state),
                )
                //getDishState(dishProvider.list[index])
                /* getDishState(dish) && dish.isActive
                                    ? stateOnBox()
                                    : stateOffBox(), */
              ],
            ),
          ),
          RouteDeliveryPage(orderDetail: orderDetail),
          _cardDish(orderDetail),
          Divider(
            color: DBColors.GRAY_12,
            indent: 28.0,
            endIndent: 28.0,
            thickness: 1.0,
          ),
          _clientName(orderDetail.order),
          Divider(
            color: DBColors.GRAY_12,
            indent: 28.0,
            endIndent: 28.0,
            thickness: 1.0,
          ),
          _deliveryType(),
          Divider(
            color: DBColors.GRAY_12,
            indent: 28.0,
            endIndent: 28.0,
            thickness: 1.0,
          ),
          _address(orderDetail.order),
          _gridLabel(orderDetail),
          _totalPrice(orderDetail.order),
          Divider(
            color: DBColors.GRAY_12,
            indent: 28.0,
            endIndent: 28.0,
            thickness: 1.0,
          ),
        ],
      ),
      //),
      //),
    );
  }

  _cardDish(OrderDetail orderDetail) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 28.0, top: 18.0, bottom: 40.0),
          child: cZeroStr(orderDetail.dish.image)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image(
                    image: NetworkImage(
                        //dishProvider.list[index].image),
                        orderDetail.dish.image),
                    height: 56.0,
                    width: 56.0,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
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
                  //'dish.dishName',
                  orderDetail.dish.dishName,
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
                  //'Entrega ${dateTimeString(dish)}',
                  '+ ${orderDetail.dish.additional.additionalDescription}',
                  style: subtitleCardPickupStyle,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 24.0),
                child: Text(
                  //'S/ ${dishProvider.list[index].priceDelivery}'
                  /* '${pluralPortion(dish)} | S/ ${dish.priceDelivery}'
                                .toString(), */
                  '${pluralPortion(orderDetail.order.portion)}',
                  style: priceCardStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _clientName(Order order) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Container(
        //color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, top: 16.0),
                  child: Text(
                    'CLIENTE',
                    style: labelTitlePickupStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    order.customerAddress.customer.user.username,
                    style: subLabelTitlePickupStyle,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 17.0, bottom: 17.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    backgroundImage:
                        cZeroStr(null) ? NetworkImage('user.pictureUri') : null,
                    child: cZeroStr(null)
                        ? null
                        : SvgPicture.asset(
                            'assets/images/user.svg',
                            height: 40.0,
                            width: 40.0,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17.0, bottom: 17.0),
                  child: SvgPicture.asset(
                    "assets/icons/phone.svg",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _deliveryType() {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 16.0),
              child: Text(
                'TIPO DE ENTREGA',
                style: labelTitlePickupStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Delivery',
                style: subLabelTitlePickupStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _address(Order order) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0, top: 16.0),
              child: Text(
                'DIRECCIÓN DE ENTREGA',
                style: labelTitlePickupStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '${order.customerAddress.address.address}',
                style: subLabelTitlePickupStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deliveryDate(OrderDetail orderDetail) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'FECHA DE ENTREGA',
              style: labelTitlePickupStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 16.0),
            child: Text(
              '${orderDateDetail(orderDetail)}',
              style: subLabelTitlePickupStyle,
            ),
          ),
        ],
      ),
    );
  }

  _schedule(DishModel dish) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 24.0),
            child: Text(
              'HORARIO',
              style: labelTitlePickupStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 16.0, left: 24.0),
            child: Text(
              '${timeFromDetail(dish)} - ${timeToDetail(dish)}',
              style: subLabelTitlePickupStyle,
            ),
          ),
        ],
      ),
    );
  }

  _gridLabel(OrderDetail orderDetail) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Container(
                //padding: const EdgeInsets.only(top: 16.0,),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: DBColors.GRAY_12,
                      width: 1.0,
                    ),
                    top: BorderSide(
                      color: DBColors.GRAY_12,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: DBColors.GRAY_12,
                      width: 1.0,
                    ),
                  ),
                ),
                child: _deliveryDate(orderDetail),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 28.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: DBColors.GRAY_12,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: DBColors.GRAY_12,
                      width: 1.0,
                    ),
                  ),
                ),
                child: _schedule(orderDetail.dish),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _totalPrice(Order order) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, top: 16.0),
                  child: Text(
                    'TOTAL COBRADO',
                    style: labelTitlePickupStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'S/ ${order.totalPrice.toString()}',
                    style: subLabelTitlePickupStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 29.0, bottom: 29.0),
              child: AngleRightIcon(
                height: 24.0,
                width: 24.0,
                color: DBColors.GRAY_2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stateOnBox(int state) {
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
              state == 1
                  ? 'RECIBIDA'
                  : state == 2
                      ? 'CONFIRMADA'
                      : state == 3
                          ? 'PREPARADA'
                          : null,
              style: stateOnStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget stateOffBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      width: 86.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: DBColors.GRAY_4,
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
    );
  }
}
