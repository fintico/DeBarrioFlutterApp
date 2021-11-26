import 'package:debarrioapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../../../utilsFunctions.dart';
import '../order_style.dart';

class OrderDetailFinishBody extends StatelessWidget {
  const OrderDetailFinishBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 24.0),
          child: Text(
            'Tu pedido',
            style: titleOrderBodyStyle,
          ),
        ),
        Row(
          children: <Widget>[
            _imageBox(orderBloc.orderDetail!.dish!.image!),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    '${orderBloc.orderDetail!.order!.portion}x ${orderBloc.orderDetail!.dish!.dishName}',
                    style: titledishOrderBodyStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 28.0),
                  child: Text(
                    orderBloc.orderDetail!.dish!.additional == null
                        ? '-'
                        : '1x ${orderBloc.orderDetail!.dish!.additional!.additionalDescription}',
                    style: subtitledishOrderBodyStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: DBColors.BLUE_LIGHT_5,
          thickness: 1.0,
          indent: 28.0,
          endIndent: 28.0,
        ),
        SizedBox(height: 8.0),
        _detailBox(
            title: 'TIPO DE ENTREGA',
            description: orderBloc.orderDetail!.order!.isDelivery!
                ? 'Delivery'
                : 'Recojo en tienda',
            state: 0),
        _detailBox(
            title: 'REPARTIDOR',
            description: orderBloc
                .orderDetail!.order!.customerAddress!.customer!.user!.username!,
            state: 1),
        _detailBox(
            title: 'DIRECCIÓN DE ENTREGA',
            description: orderBloc
                .orderDetail!.order!.customerAddress!.address!.address!,
            state: 0),
        _detailBox(
            title: 'TOTAL PAGADO',
            description: 'S/ ${orderBloc.orderDetail!.order!.totalPrice}',
            state: 2),
        _detailPaymentMethodBox(
          title: 'MÉTODO DE PAGO',
          description:
              '${toShortCreditCardNumber(orderBloc.orderDetail!.order!.creditCard!.cardNumber!)}',
          date: '${orderBloc.orderDetail!.order!.createdAt!}',
          type: orderBloc.orderDetail!.order!.creditCard!.cardType!.id!,
        ),
      ],
    );
  }

  _imageBox(String urlImage) {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, top: 16.0, bottom: 24.0),
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
                height: 56.0,
                width: 56.0,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  _detailBox({String? title, String? description, int? state}) {
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
                    title!,
                    style: titleDetailBoxOrderBodyStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 16.0),
                  child: Text(
                    description!,
                    style: subtitleDetailBoxOrderBodyStyle,
                  ),
                ),
              ],
            ),
            _caseBox(state!),
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

  _detailPaymentMethodBox(
      {String? title, String? description, String? date, int? type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 16.0),
          child: Text(
            'MÉTODO DE PAGO',
            style: titleDetailBoxOrderBodyStyle,
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
                style: numberDetailBoxOrderBodyStyle,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 3.0, bottom: 15.0),
          child: Text(
            '${convertUtcToLocal(date!)}',
            style: subtitleDetailBoxOrderBodyStyle,
          ),
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
        return Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 17.0, bottom: 17.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                backgroundImage:
                    cZeroStr(null) ? NetworkImage('user.pictureUri') : null,
                child: cZeroStr(null)
                    ? SizedBox(height: 0.0)
                    : SvgPicture.asset(
                        'assets/images/user.svg',
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 17.0, bottom: 17.0, right: 28.0),
              child: SvgPicture.asset(
                "assets/icons/phone.svg",
                height: 40.0,
                width: 40.0,
              ),
            ),
          ],
        );
        break;
      case 2:
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
                  'type': 2,
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
