import 'package:debarrioapp/providers/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'filter_style.dart';

class DeliveryTypeItem extends StatelessWidget {
  const DeliveryTypeItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 32.0),
          child: Text('TIPO DE ENTREGA', style: titleSectionFilterStyle),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 13.0),
              child: InkWell(
                onTap: () {
                  //print('delivery');
                  homeBloc.onDeliveryType(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: DBColors.GRAY_4,
                    borderRadius: BorderRadius.circular(4.0),
                    border: homeBloc.deliveryType == 1
                        ? Border.all(color: DBColors.BLACK, width: 1.0)
                        : null,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 12.0, bottom: 12.0),
                        child: SvgPicture.asset(
                          'assets/images/delivery_type.svg',
                          height: 48.0,
                          width: 48.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 11.0, top: 16.0, bottom: 16.0, right: 20.0),
                        child: Text('Delivery', style: textDeliveryTypeStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28.0, top: 13.0),
              child: InkWell(
                onTap: () {
                  homeBloc.onDeliveryType(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: DBColors.GRAY_4,
                    borderRadius: BorderRadius.circular(4.0),
                    border: homeBloc.deliveryType == 2
                        ? Border.all(color: DBColors.BLACK, width: 1.0)
                        : null,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19.0, top: 12.0, bottom: 12.0),
                        child: SvgPicture.asset(
                          'assets/images/pickup_type.svg',
                          height: 48.0,
                          width: 48.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 16.0, bottom: 16.0, right: 32.0),
                        child: Text('Recojo', style: textDeliveryTypeStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
