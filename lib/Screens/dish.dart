import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:sailor/sailor.dart';

class DishConfirm extends StatefulWidget {
  final int? dishId;

  const DishConfirm({Key? key, this.dishId}) : super(key: key);
  @override
  _DishConfirmState createState() => _DishConfirmState();
}

class _DishConfirmState extends State<DishConfirm> {
  //PostedDish postedDish;

  TextStyle titleStyle = DBStyles.getStyle(
    DBStyles.YELLOW,
    DBStyles.FONT_SYZE_H2,
    DBStyles.FONT_HEIGHT_H2,
    0,
    DBStyles.FONT_WEIGHT_BOLD,
  );

  TextStyle subTitleStyle = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_L,
    DBStyles.FONT_HEIGHT_L,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle descriptionStyle = DBStyles.getStyle(
    DBStyles.GRAY_7,
    DBStyles.FONT_SYZE_S,
    DBStyles.FONT_HEIGHT_S,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: Container(
          child: AppBarOptionOne(
            leftIconAction: () => {} /* Navigator.pop(context) */,
          ),
        ),
        preferredSize: Size.fromHeight(52.0));
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.BLACK,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/dish.svg',
                        height: 88.0,
                        width: 88.0,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    child: Text(
                      "¡Listo! Tu publicación\n está activa",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: titleStyle,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    child: Text(
                      "Prepárate para los pedidos de la\n gente de tu barrio.",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: subTitleStyle,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                    child: Text(
                      'Recuerda que puedes revisar las ventas que \n realices en la sección "Mis ventas"',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: descriptionStyle,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: GenericButtonOrange(
                        text: 'VER PUBLICACIÓN',
                        disable: false,
                        action: () {
                          _removeDish();
                          Routes.sailor.navigate(
                            Routes.DISH_DETAIL_SCREEN,
                            navigationType: NavigationType.pushReplace,
                            removeUntilPredicate: (route) => true,
                            params: {
                              'dishId': widget.dishId,
                            },
                          );
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _removeDish() {
    dish.dishName = "";
    dish.urlImage = "";
    dish.dishStock = null;
    dish.dishDeliveryDate = "";
    dish.dishDeliveryFromTime = "";
    dish.dishDeliveryToTime = "";
    dish.dishDeliveryPrice = null;
    dish.dishPickUpPrice = null;
    dish.dishCategory = null;
    dish.dishAdditional = null;
  }
}
