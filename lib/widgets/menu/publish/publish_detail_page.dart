import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:debarrioapp/widgets/components/icons/edit.dart';
import 'package:debarrioapp/widgets/components/icons/trash.dart';
import 'package:debarrioapp/widgets/dish/dish_statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_eight.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import '../../../utilsFunctions.dart';
import 'publish_style.dart';

class PublishDetail extends StatelessWidget {
  final int dishId;
  final bool isActive;
  final DishModel dishModel;
  const PublishDetail({Key key, this.dishId, this.isActive, this.dishModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final dishProvider = Provider.of<DishProvider>(context);
    //getDishById(context, dishProvider);
    final appBar = PreferredSize(
        child: AppBarOptionEight(
            leftIconAction: () => Routes.sailor.navigate(
                Routes.DISH_LIST_SCREEN,
                navigationType: NavigationType.push),
            headerTitle: 'Detalle de la publicación',
            rightIconAction: () => {detailsBottomSheet(context, dishModel)}),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: DBColors.GRAY_12,
        body: _buildBody(context),
        bottomNavigationBar: _bottomNavBar(dishModel),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<DishService>(context, listen: false).getDishById(dishId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          DishModel dish =
              DishModel.fromJson(json.decode(snapshot.data.bodyString));
          //dishProvider.onActive(true);
          //isActive = dish.isActive;
          return _buildDish(context, dish);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildDish(BuildContext context, DishModel dish) {
    return Container(
      color: DBColors.WHITE,
      width: screenWidth(context),
      //height: screenHeight(context, dividedBy: 1.63),
      /* height: dish.additional != null
          ? screenHeight(context, dividedBy: 1.63)
          : screenHeight(context, dividedBy: 1), */
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 26.0, left: 28.0, right: 28.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "PUBLICACIÓN #0${dish.id}",
                      style: publishtitleDetailStyle,
                    ),
                    getDishState(dish) && dish.isActive
                        ? stateOnBox()
                        : stateOffBox(),
                  ],
                ),
              ),
            ),
            _dishImage(context, dish),
            DishStatisticsCard(),
            detailsDish(
              title: 'TÍTULO DE LA VENTA',
              description: dish.dishName,
              descriptionStyle: descriptionDishStyle,
            ),
            detailsDish(
              title: 'CATEGORÍA',
              description: dish.dishCategory.dishCategoryDescription,
              descriptionStyle: descriptionStyle,
            ),
            detailsDish(
              title: 'STOCK DE PORCIONES',
              description: dish.stock.toString(),
              descriptionStyle: descriptionStyle,
            ),
            gridDetailDish(
              titleLeft: 'FECHA DE ENTREGA',
              descriptionLeft: dateTimeDetail(dish),
              titleRight: 'HORARIO',
              descriptionRight: timeDetail(dish),
              descriptionStyle: descriptionStyle,
            ),
            gridDetailDish(
              titleLeft: 'PRECIO DELIVERY',
              descriptionLeft: 'S/ ${dish.priceDelivery.toString()}',
              titleRight: 'PRECIO CON RECOJO',
              descriptionRight: 'S/ ${dish.pricePickup.toString()}',
              descriptionStyle: descriptionStyle,
            ),
            detailsDish(
              title: 'UBICACIÓN ACTUAL',
              description: dish.address.address,
              descriptionStyle: descriptionStyle,
            ),
            _additionalDetail(context, dish),
          ],
        ),
      ),
    );
  }

  Future getDishById(context, DishProvider dishProvider) async {
    //await Future.delayed(Duration(seconds: 0));
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false)
              .getDishById(dishId);
      //inspect(res);
      if (res.isSuccessful) {
        DishModel dishModel = DishModel.fromJson(json.decode(res.bodyString));
        dishProvider.dish = dishModel;
      } else {
        //print('nel');
      }
    } catch (e) {
      //print('aea');
      //print(e);
    }
  }

  Widget _dishImage(context, DishModel dish) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 4.0),
      child: Container(
        padding: const EdgeInsets.only(left: 0.0, top: 18.0, bottom: 24.0),
        child: cZeroStr(dish.image)
            ? Image(
                image: NetworkImage(dish.image),
                //height: 56.0,
                //width: 56.0,
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
              )
            : SvgPicture.asset(
                'assets/images/empty.svg',
                //height: 46.0,
                //width: 46.0,
                fit: BoxFit.contain,
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

  Widget _additionalDetail(context, DishModel dish) {
    return Container(
      //height: 200.0,
      height:
          dish.additional != null ? screenHeight(context, dividedBy: 3.72) : 1,
      child: Column(
        children: [
          Container(
            //height: 70.0,
            color: DBColors.WHITE,
            child: Column(
              children: [
                dish.additional != null
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
                                          dish.additional.additionalDescription,
                                          style: bNavbarSubTitleStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 28.0,
                                          bottom: 20.0,
                                        ),
                                        child: Text(
                                          'S/ ${dish.additional.price.toString()}',
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

  _bottomNavBar(DishModel dishModel) {
    return getDishState(dishModel) && dishModel.isActive
        ? SizedBox(height: 1.0)
        : Container(
            color: DBColors.WHITE,
            padding: const EdgeInsets.only(
                top: 20.0, left: 28.0, right: 28.0, bottom: 24.0),
            child: GenericButtonOrange(
                text: 'VOLVER A PUBLICAR',
                disable: false,
                action: () {
                  Routes.sailor.navigate(Routes.DISH_REPUBLISH_SCREEN,
                      navigationType: NavigationType.push,
                      params: {'dishModel': dishModel});
                }),
          );
  }

  void detailsBottomSheet(BuildContext context, DishModel dishModel) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (context) {
          return Container(
            //height: MediaQuery.of(context).size.height * 0.25,
            height: getDishState(dishModel) && dishModel.isActive
                ? screenHeight(context, dividedBy: 4.0)
                : screenHeight(context, dividedBy: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 34.0, top: 44.0, bottom: 20.0),
                        child: EditIcon(
                            height: 20.0, width: 20.0, color: DBColors.GRAY_2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, top: 44.0, bottom: 20.0),
                        child: Text(
                          'Editar publicación',
                          style: bottonDetailModalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: DBColors.GRAY_12,
                  thickness: 1.0,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                getDishState(dishModel) && dishModel.isActive
                    ? InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          deleteBottomSheet(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 34.0, top: 20.0, bottom: 20.0),
                              child: TrashIcon(
                                  height: 20.0,
                                  width: 20.0,
                                  color: DBColors.GRAY_2),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0, top: 20.0, bottom: 20.0),
                              child: Text(
                                'Eliminar publicación',
                                style: bottonDetailModalStyle,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1.0,
                      )
              ],
            ),
          );
        });
  }

  void deleteBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: screenHeight(context, dividedBy: 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 28.0, right: 28.0),
                  child: Text(
                    '¿Estás seguro de eliminar esta \n publicación?',
                    style: bottonDetailDeleteTitleModalStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 28.0),
                  child: Text(
                    'No podrás revertir esta acción',
                    style: bottonDetailDeleteSubTitleModalStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 28.0, right: 28.0),
                  child: GenericButtonOrange(
                      text: 'SÍ, ELIMINAR',
                      disable: false,
                      action: () {
                        Routes.sailor.navigate(
                          Routes.SPLASH_LOADING_DISH_DELETE_SCREEN,
                          navigationType: NavigationType.pushReplace,
                          params: {'id': dishId},
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 28.0, right: 28.0, bottom: 24.0),
                  child: GenericButtonWhite(
                      text: 'CANCELAR', disable: false, action: () {}),
                )
              ],
            ),
          );
        });
  }
}
