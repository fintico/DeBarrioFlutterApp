import 'package:debarrioapp/widgets/home/filters/filter_bottom_item.dart';
import 'package:debarrioapp/widgets/home/filters/filter_delivery_type_item.dart';
import 'package:debarrioapp/widgets/home/filters/filter_dish_style_item.dart';
import 'package:debarrioapp/widgets/home/filters/filter_dish_type_item.dart';
import 'package:debarrioapp/widgets/home/filters/filter_life_style_item.dart';
import 'package:debarrioapp/widgets/home/filters/filter_time_item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_five.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionFive(
        leftIconAction: () => Navigator.pop(context),
        headerTitle: 'Filtra tus preferencias',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DeliveryTypeItem(),
              DishTypeItem(),
              DishStyleItem(),
              TimeItem(),
              LifeStyleItem(),
            ],
          ),
        ),
        bottomNavigationBar: FilterBottom(),
      ),
    );
  }
}
