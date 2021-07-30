import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:debarrioapp/widgets/menu/order/ongoing_order/order_detail_ongoing_status_item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../../../utilsFunctions.dart';

import 'order_ongoing_style.dart';

class OrderDetailOngoingBody extends StatelessWidget {
  const OrderDetailOngoingBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: DBColors.GRAY_8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    height: 4.0,
                    width: 48.0,
                    decoration: BoxDecoration(
                      color: DBColors.GRAY_10,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 20.0),
                  child: Text(
                    'ENTREGA PROGRAMA',
                    style: titleDetailBoxOrderOngoingStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 24.0),
                  child: Text(
                    '${dateSaleTimeString(orderBloc.orderDetail.dish, orderBloc.orderDetail.order)}',
                    style: subtitleDetailBoxOrderOngoingStyle,
                  ),
                ),
                Divider(
                  color: DBColors.BLUE_LIGHT_5,
                  thickness: 1.0,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 24.0),
                  child: Text('¡Tu orden ha sido preparada!'),
                ),
                OrderDetailOngingStatus(),
                Divider(
                  color: DBColors.BLUE_LIGHT_5,
                  thickness: 1.0,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _imageBox(orderBloc.orderDetail.dish.seller.urlImage),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 29.0),
                              child: Text(
                                orderBloc
                                    .orderDetail.dish.seller.restaurantName,
                                style: titleDetailOrderOngoingStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 4.0, bottom: 28.0),
                              child: Text(
                                '${toAddressShort(orderBloc.orderDetail.dish.address.address)}',
                                style: subtitleDetailOrderOngoingStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, right: 28.0),
                      child: SvgPicture.asset(
                        "assets/icons/phone.svg",
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                  child: Text(
                    '${orderBloc.orderDetail.order.portion}x ${orderBloc.orderDetail.dish.dishName}',
                    style: descriptionDetailOrderOngoingStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 28.0, top: 8.0, bottom: 24.0),
                  child: Text(
                    orderBloc.orderDetail.dish.additional == null
                        ? '-'
                        : '1x ${orderBloc.orderDetail.dish.additional.additionalDescription}',
                    style: descriptionDetailOrderOngoingStyle,
                  ),
                ),
                Divider(
                  color: DBColors.BLUE_LIGHT_5,
                  thickness: 1.0,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                _detailBox(
                  title: 'DIRECCIÓN DE ENTREGA',
                  description:
                      '${orderBloc.orderDetail.order.customerAddress.address.address}',
                  state: 0,
                ),
                _detailBox(
                  title: 'TOTAL PAGADO',
                  description: 'S/ ${orderBloc.orderDetail.order.totalPrice}',
                  state: 1,
                ),
                _detailPaymentMethodBox(
                  title: 'MÉTODO DE PAGO',
                  description:
                      '${toShortCreditCardNumber(orderBloc.orderDetail.order.creditCard.cardNumber)}',
                  type: orderBloc.orderDetail.order.creditCard.cardType.id,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imageBox(String urlImage) {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, top: 24.0),
      child: cZeroStr(urlImage)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(
                image: NetworkImage(
                    //dishProvider.list[index].image),
                    urlImage),
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
                height: 56.0,
                width: 56.0,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  _detailBox({String title, String description, int state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                  child: Text(
                    title,
                    style: titleDetailBoxOrderOngoingStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 16.0),
                  child: Text(
                    description,
                    style: subtitleDetailBoxOrderOngoingStyle,
                  ),
                ),
              ],
            ),
            _caseBox(state),
          ],
        ),
        Divider(
          color: DBColors.BLUE_LIGHT_5,
          thickness: 1.0,
          indent: 28.0,
          endIndent: 28.0,
        ),
      ],
    );
  }

  _detailPaymentMethodBox({String title, String description, int type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 16.0),
          child: Text(
            title,
            style: titleDetailBoxOrderOngoingStyle,
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 4.0),
              child: SvgPicture.asset(
                type == 1
                    ? 'assets/images/visa.svg'
                    : 'assets/images/mastercard.svg',
                height: 24.0,
                width: 40.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4.0),
              child: Text(
                //'**** ${creditCard.cardNumber.substring(creditCard.cardNumber.length - 5)}',
                '**** $description',
                style: numberDetailBoxOrderOngoingStyle,
              ),
            ),
          ],
        ),
        Divider(
          color: DBColors.BLUE_LIGHT_5,
          thickness: 1.0,
          indent: 28.0,
          endIndent: 28.0,
        ),
      ],
    );
  }

  _caseBox(int state) {
    switch (state) {
      case 1:
        return Padding(
          padding: const EdgeInsets.only(right: 28.0, top: 29.0, bottom: 29.0),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              print('precio');
              Routes.sailor.navigate(
                Routes.ORDER_PAYMENT_SUMMARY_SCREEN,
                navigationType: NavigationType.push,
                params: {
                  'type': 1,
                },
              );
            },
            child: AngleRightIcon(
              height: 16.0,
              width: 16.0,
              color: DBColors.GRAY_2,
            ),
          ),
        );
        break;
      default:
        return SizedBox(
          height: 0.0,
        );
    }
  }
}
