import 'package:debarrioapp/models/additionalDish.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_eight.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:sailor/sailor.dart';

import 'dish_statistics_card.dart';
import 'dish_style.dart';

class DishDetail extends StatefulWidget {
  DishDetail({Key key}) : super(key: key);

  @override
  _DishDetailState createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  Random random = new Random();
  int randomNumber;
  @override
  @override
  void initState() {
    super.initState();
    randomNumber = random.nextInt(900000);
  }

  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: AppBarOptionEight(
            leftIconAction: () => Routes.sailor.navigate(Routes.HOME_SCREEN,
                navigationType: NavigationType.pushReplace),
            headerTitle: 'Detalle de la publicación',
            rightIconAction: () => {}),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
          appBar: appBar,
          backgroundColor: DBColors.GRAY_12,
          body: Container(
            color: DBColors.WHITE,
            width: screenWidth(context),
            //height: screenHeight(context, dividedBy: 1.63),
            height: dish.dishAdditional != null
                ? screenHeight(context, dividedBy: 1.63)
                : screenHeight(context, dividedBy: 1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 26.0, left: 28.0, right: 28.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PUBLICACIÓN #0$randomNumber",
                            style: publishtitleDetailStyle,
                          ),
                          stateOnBox(),
                        ],
                      ),
                    ),
                  ),
                  _dishImage(),
                  DishStatisticsCard(),
                  detailsDish(
                    title: 'TÍTULO DE LA VENTA',
                    description: dish.dishName,
                    descriptionStyle: descriptionDishStyle,
                  ),
                  detailsDish(
                    title: 'CATEGORÍA',
                    description: dish.category,
                    descriptionStyle: descriptionStyle,
                  ),
                  detailsDish(
                    title: 'STOCK DE PORCIONES',
                    description: dish.dishStock.toString(),
                    descriptionStyle: descriptionStyle,
                  ),
                  gridDetailDish(
                    titleLeft: 'FECHA DE ENTREGA',
                    descriptionLeft: dish.date,
                    titleRight: 'HORARIO',
                    descriptionRight: '${dish.timeFrom} - ${dish.timeTo}',
                    descriptionStyle: descriptionStyle,
                  ),
                  gridDetailDish(
                    titleLeft: 'PRECIO DELIVERY',
                    descriptionLeft: dish.dishDeliveryPrice.toString(),
                    titleRight: 'PRECIO CON RECOJO',
                    descriptionRight: dish.dishPickUpPrice.toString(),
                    descriptionStyle: descriptionStyle,
                  ),
                  detailsDish(
                    title: 'UBICACIÓN ACTUAL',
                    description: userAppData.address,
                    descriptionStyle: descriptionStyle,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _botomNavBar()),
    );
  }

  Widget _dishImage() {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 4.0),
      child: Container(
        padding: const EdgeInsets.only(left: 0.0, top: 18.0, bottom: 24.0),
        child: Image(
          image: NetworkImage(dish.urlImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget detailsDish({
    String title,
    String description,
    TextStyle descriptionStyle,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 28.0,
        top: 32.0,
        right: 28.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subTitleStyle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            description,
            style: descriptionStyle,
          ),
          title == 'UBICACIÓN ACTUAL'
              ? SizedBox(
                  height: 16.0,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Divider(
                    color: DBColors.BLUE_LIGHT_2,
                    height: 1.0,
                    //endIndent: 28.0,
                    thickness: 1.0,
                  ),
                ),
        ],
      ),
    );
  }

  Widget detailsRightDish({
    String title,
    String description,
    TextStyle descriptionStyle,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        top: 32.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              title,
              style: subTitleStyle,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              description,
              style: descriptionStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Divider(
              color: DBColors.BLUE_LIGHT_2,
              height: 1.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsLefttDish({
    String title,
    String description,
    TextStyle descriptionStyle,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 28.0,
        top: 32.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subTitleStyle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            description,
            style: descriptionStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Divider(
              color: DBColors.BLUE_LIGHT_2,
              height: 1.0,
              //endIndent: 28.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridDetailDish({
    String titleLeft,
    String titleRight,
    String descriptionLeft,
    String descriptionRight,
    TextStyle descriptionStyle,
  }) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                ),
              ),
              child: detailsLefttDish(
                title: titleLeft,
                description: descriptionLeft,
                descriptionStyle: descriptionStyle,
              ),
            ),
          ),
          Expanded(
            child: detailsRightDish(
              title: titleRight,
              description: descriptionRight,
              descriptionStyle: descriptionStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _botomNavBar() {
    return Container(
      //height: 200.0,
      height: dish.dishAdditional != null
          ? screenHeight(context, dividedBy: 3.72)
          : 1,
      child: Column(
        children: [
          Container(
            //height: 70.0,
            color: DBColors.WHITE,
            child: Column(
              children: [
                dish.dishAdditional != null
                    ? Container(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, top: 32.0, bottom: 16.0),
                              child: Text(
                                'ADICIONALES',
                                style: bNavbarTitleStyle,
                              ),
                            ),
                            Divider(
                              color: DBColors.BLUE_LIGHT_5,
                              thickness: 1.0,
                              indent: 28.0,
                              endIndent: 28.0,
                            ),
                            InkWell(
                              onTap: () {
                                /* randomNumber = random.nextInt(900000);
                                print(randomNumber); */
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                /* crossAxisAlignment: CrossAxisAlignment.start, */
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 28.0,
                                          top: 20.0,
                                        ),
                                        child: Text(
                                          dish.dishAdditional != null
                                              ? additionalDish
                                                  .additionalDescription
                                              : "",
                                          style: bNavbarSubTitleStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 28.0,
                                          bottom: 20.0,
                                        ),
                                        child: Text(
                                          dish.dishAdditional != null
                                              ? 'S/ ${additionalDish.price.toString()}'
                                              : "",
                                          style: bNavbarDescriptionStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 28.0,
                                      top: 34.0,
                                      bottom: 34.0,
                                    ),
                                    child: AngleRightIcon(
                                      height: 20.0,
                                      width: 20.0,
                                      color: DBColors.GRAY_2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: DBColors.BLUE_LIGHT_5,
                              thickness: 1.0,
                              indent: 28.0,
                              endIndent: 28.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 0.1,
                      ),
              ],
            ),
          ),
        ],
      ),
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
}
