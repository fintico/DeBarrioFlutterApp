import 'dart:math';

import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../../utilsFunctions.dart';
import 'publish_style.dart';

class PublishCard extends StatelessWidget {
  final int index;
  final DishModel dish;
  const PublishCard({Key key, this.index, this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final dishProvider = Provider.of<DishProvider>(context);
    /* Random random = new Random();
    int randomNumber;
    randomNumber = random.nextInt(900000); */
    return Column(
      children: [
        InkWell(
          onTap: () => {
            Routes.sailor.navigate(Routes.DISH_PUBLISH_DETAIL,
                //params: {'id': dishProvider.list[index].id}),
                navigationType: NavigationType.pushReplace,
                params: {
                  'id': dish.id,
                  'isActive': dish.isActive,
                  'dishModel': dish
                }),
            //print('${dishProvider.list[index].id}')
          },
          child: Container(
              color: DBColors.WHITE,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 22.0, left: 28.0, right: 28.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            //"PUBLICACIÓN #0${dishProvider.list[index].id}",
                            "PUBLICACIÓN #0${dish.id}",
                            style: publishCardtitleStyle,
                          ),
                          //getDishState(dishProvider.list[index])
                          getDishState(dish) && dish.isActive
                              ? stateOnBox()
                              : stateOffBox(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 18.0, bottom: 40.0),
                        child: //cZeroStr(dishProvider.list[index].image)
                            cZeroStr(dish.image)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Image(
                                      image: NetworkImage(
                                          //dishProvider.list[index].image),
                                          dish.image),
                                      height: 56.0,
                                      width: 56.0,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
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
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 18.0),
                              child: Text(
                                //dishProvider.list[index].dishName,
                                dish.dishName,
                                style: titleCardStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 4.0),
                              child: Text(
                                /*  dishProvider.list[index].deliveryDate +
                                    dishProvider.list[index].deliveryTimeFrom +
                                    dishProvider.list[index].deliveryTimeTo, */
                                //'Entrega ${dateTimeString(dishProvider.list[index])}',
                                'Entrega ${dateTimeString(dish)}',
                                style: subtitleCardStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 4.0, bottom: 24.0),
                              child: Text(
                                //'S/ ${dishProvider.list[index].priceDelivery}'
                                'S/ ${dish.priceDelivery}'.toString(),
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
              )),
        ),
        SizedBox(
          height: 0.0,
        ),
      ],
    );
  }

  Widget stateOnBox() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        width: 62.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: DBColors.GREEN_LIGHT,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: DBColors.GREEN,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Text(
              'ACTIVA',
              style: stateOnStyle,
            ),
          ],
        ),
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
      ),
    );
  }
}
