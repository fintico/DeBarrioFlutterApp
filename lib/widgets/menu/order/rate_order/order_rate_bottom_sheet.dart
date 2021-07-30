import 'package:debarrioapp/services/rating_service.dart';
import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';
import 'package:debarrioapp/widgets/menu/order/rate_order/order_rate_confimation.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'order_rate_style.dart';
import '../../../../utilsFunctions.dart';

class OrderRateBottomSheet extends StatelessWidget {
  const OrderRateBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Container(
      height: orderBloc.rate >= 2
          ? screenHeight(context, dividedBy: 1.7)
          : screenHeight(context, dividedBy: 3.0),
      child: Column(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 16.0, right: 16.0),
              alignment: Alignment.topRight,
              child:
                  CrossIcon(height: 24.0, width: 24.0, color: DBColors.GRAY_2),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 24.0),
                child: cZeroStr(null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image(
                          image: NetworkImage('orderDetail.dish.image'),
                          height: 48.0,
                          width: 48.0,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                          height: 48.0,
                          width: 48.0,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 28.0, top: 24.0),
                child: Text(
                  '¿Qué tal te fue con tu pedido de \n La Buena Sazón?',
                  style: titleBottomSheetRateStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  orderBloc.isRated(1);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 68.0, top: 32.0),
                  child: StarIcon(
                    height: 32.0,
                    width: 32.0,
                    color: orderBloc.rate >= 1
                        ? DBColors.YELLOW
                        : DBColors.GRAY_16,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  orderBloc.isRated(2);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                  child: StarIcon(
                    height: 32.0,
                    width: 32.0,
                    color: orderBloc.rate >= 2
                        ? DBColors.YELLOW
                        : DBColors.GRAY_16,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  orderBloc.isRated(3);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                  child: StarIcon(
                    height: 32.0,
                    width: 32.0,
                    color: orderBloc.rate >= 3
                        ? DBColors.YELLOW
                        : DBColors.GRAY_16,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  orderBloc.isRated(4);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 32.0),
                  child: StarIcon(
                    height: 32.0,
                    width: 32.0,
                    color: orderBloc.rate >= 4
                        ? DBColors.YELLOW
                        : DBColors.GRAY_16,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  orderBloc.isRated(5);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 32.0, right: 68.0),
                  child: StarIcon(
                    height: 32.0,
                    width: 32.0,
                    color: orderBloc.rate >= 5
                        ? DBColors.YELLOW
                        : DBColors.GRAY_16,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 56.0, top: 16.0),
                child: Text(
                  'NADA BIEN',
                  style: submitBottomSheetRateStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 59.0, top: 16.0),
                child: Text(
                  'MUY BIEN',
                  style: submitBottomSheetRateStyle,
                ),
              ),
            ],
          ),
          orderBloc.rate >= 2
              ? ratingComments(context, orderBloc)
              : SizedBox(
                  height: 0.0,
                )
        ],
      ),
    );
  }

  ratingComments(BuildContext context, OrderBloc orderBloc) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 31.0),
          child: Text(
            orderBloc.rate == 5
                ? '¿Qué es lo que más te gustó?'
                : '¿Qué es lo que debemos mejorar?',
            style: questionBottomSheetRateStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 35.0, top: 15.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 16.0,
            children: <Widget>[
              InkWell(
                onTap: () {
                  print('rated text');
                  orderBloc.onDisable();
                  orderBloc.onRatedComment(1);
                },
                child: _rateChip(
                  'Sabor de la comida',
                  orderBloc.rateComment == 1
                      ? DBColors.GRAY_7
                      : DBColors.GRAY_6,
                ),
              ),
              InkWell(
                onTap: () {
                  print('rated text');
                  orderBloc.onDisable();
                  orderBloc.onRatedComment(2);
                },
                child: _rateChip(
                  'Limpieza',
                  orderBloc.rateComment == 2
                      ? DBColors.GRAY_7
                      : DBColors.GRAY_6,
                ),
              ),
              InkWell(
                onTap: () {
                  print('rated text');
                  orderBloc.onDisable();
                  orderBloc.onRatedComment(3);
                },
                child: _rateChip(
                  'Tiempo de entrega',
                  orderBloc.rateComment == 3
                      ? DBColors.GRAY_7
                      : DBColors.GRAY_6,
                ),
              ),
              InkWell(
                onTap: () {
                  print('rated text');
                  orderBloc.onDisable();
                  orderBloc.onRatedComment(4);
                },
                child: _rateChip(
                  'Presentación',
                  orderBloc.rateComment == 4
                      ? DBColors.GRAY_7
                      : DBColors.GRAY_6,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28, top: 32.0, right: 28.0),
          child: GenericButtonOrange(
            text: 'ENVIAR',
            disable: orderBloc.isDisable,
            action: () {
              print('enviar');
              print(orderBloc.rate);
              print(orderBloc.orderDetail.dish.seller.id);
              Navigator.pop(context);
              _ratingSeller(context, orderBloc);
              orderBloc.removeAll();
              confirmationBottomSheet(context);
            },
          ),
        ),
      ],
    );
  }

  _rateChip(String dishType, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, top: 6.0, bottom: 6.0, right: 24.0),
        child: Text(dishType, style: textChipBottomSheetRateStyle),
      ),
    );
  }

  void confirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      builder: (context) {
        return OrderRateConfirmation();
      },
    );
  }

  Future _ratingSeller(BuildContext context, OrderBloc orderBloc) async {
    await Provider.of<RatingService>(context, listen: false)
        .postRateSeller(orderBloc.rate, orderBloc.orderDetail.dish.seller.id);
  }
}
