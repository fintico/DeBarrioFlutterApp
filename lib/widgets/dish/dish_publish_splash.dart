import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:debarrioapp/constants/url_base.dart' as Url;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class DishSplash extends StatefulWidget {
  DishSplash({Key key}) : super(key: key);

  @override
  _DishSplashState createState() => _DishSplashState();
}

class _DishSplashState extends State<DishSplash> {
  TextStyle title = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_L,
    DBStyles.FONT_HEIGHT_L,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    publishDish();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: screenHeight(context),
          decoration: BoxDecoration(color: DBColors.BLACK),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  child: SvgPicture.asset(
                    'assets/icons/loading.svg',
                    height: 124,
                    width: 224,
                    color: DBColors.WHITE,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Un momento, \n estamos publicando \n tu venta...',
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future publishDish() async {
    final prefs = new UserPreferences();
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context).postSellerDish(
        dish.dishName,
        //dish.urlImage,
        dish.dishStock,
        dish.dishDeliveryDate,
        dish.dishDeliveryFromTime,
        dish.dishDeliveryToTime,
        dish.dishDeliveryPrice,
        dish.dishPickUpPrice,
        prefs.userId,
        dish.dishCategory,
        dish.dishAdditional,
        homeBloc.sellerAddress.address.id,
      );

      Map<String, dynamic> jsonMap = json.decode(res.bodyString);
      await Future.delayed(Duration(seconds: 1));
      await Provider.of<DishService>(context, listen: false)
          .updateDishImage(jsonMap["id"], 'urlImage', dish.urlImage);

      //Map<String, dynamic> jsonImage = json.decode(resImage.bodyString);
      //dish.urlImage = '${Url.API_BASE_URL + jsonImage["image"]}';

      Routes.sailor.navigate(Routes.SPLASH_CONFIRM_DISH_PUBLISH_SCREEN,
          navigationType: NavigationType.pushReplace,
          removeUntilPredicate: (route) => true,
          params: {
            'dishId': jsonMap["id"],
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
