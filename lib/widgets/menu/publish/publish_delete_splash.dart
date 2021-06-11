import 'package:chopper/chopper.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class PublishDelete extends StatelessWidget {
  final int dishId;
  const PublishDelete({Key key, this.dishId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deleteDish(context);
    TextStyle title = DBStyles.getStyle(
      DBStyles.WHITE,
      DBStyles.FONT_SYZE_L,
      DBStyles.FONT_HEIGHT_L,
      0,
      DBStyles.FONT_WEIGHT_REGULAR,
    );

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
                  'Un momento...',
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

  Future deleteDish(BuildContext context) async {
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context).deleteDish(dishId, false);
      print(res.bodyString);
      Routes.sailor.navigate(
        Routes.DISH_LIST_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
      );
    } catch (e) {
      print(e);
    }
  }
}
