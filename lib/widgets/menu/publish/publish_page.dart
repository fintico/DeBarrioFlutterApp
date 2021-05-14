import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/Services/dish_service.dart';
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
            leftIconAction: () => Routes.sailor.navigate(Routes.HOME_SCREEN,
                navigationType: NavigationType.pushReplace),
            headerTitle: 'Mis publicaciones'),
        preferredSize: Size.fromHeight(56.0));
    final dishProvider = Provider.of<DishProvider>(context);
    getDish(context, dishProvider);
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: ListView.builder(
            itemCount: dishProvider.list.length,
            itemBuilder: (context, index) => PublishCard(index: index),
          ),
        ),
      ),
    );
  }

  Future getDish(BuildContext context, DishProvider dishProvider) async {
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false).getDishList();
      //List<dynamic> jsonBody = json.decode(res.bodyString);
      List<DishModel> dishModel = (json.decode(res.bodyString) as List)
          .map((e) => DishModel.fromJson(e))
          .toList();

      dishProvider.setList(dishModel);
    } catch (e) {
      print(e);
    }
  }
}
