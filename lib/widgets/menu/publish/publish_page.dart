import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/widgets/menu/publish/publish_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

class PublishPage extends StatelessWidget {
  const PublishPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: AppBarOptionSix(
            leftIconAction: () => Routes.sailor.navigate(Routes.MENU_SCREEN,
                    navigationType: NavigationType.pushReplace,
                    transitions: [
                      SailorTransition.fade_in,
                      SailorTransition.slide_from_left
                    ]),
            headerTitle: 'Mis publicaciones'),
        preferredSize: Size.fromHeight(56.0));
    //final dishProvider = Provider.of<DishProvider>(context);
    //getDish(context, dishList);
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: _buildBody(context),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DishService>(context).getDishList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          /* if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          } */
          final List<DishModel> dishes =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => DishModel.fromJson(e))
                  .toList();
          return _buildDishes(context, dishes);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildDishes(BuildContext context, List<DishModel> dishes) {
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (BuildContext context, int index) {
        return PublishCard(
          index: index,
          dish: dishes[index],
        );
      },
    );
  }

  Future getDish(BuildContext context, dishList) async {
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false).getDishList();
      //List<dynamic> jsonBody = json.decode(res.bodyString);
      dishList = (json.decode(res.bodyString) as List)
          .map((e) => DishModel.fromJson(e))
          .toList();
      inspect(dishList);
      //dishProvider.setList(dishModel);
    } catch (e) {
      print(e);
    }
  }
}
