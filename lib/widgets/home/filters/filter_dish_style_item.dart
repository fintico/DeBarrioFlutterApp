import 'package:flutter/material.dart';

import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'filter_style.dart';

class DishStyleItem extends StatelessWidget {
  const DishStyleItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 23.0),
          child: Text('ESTILO DE COMIDA', style: titleSectionFilterStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 12.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 16.0,
            children: <Widget>[
              InkWell(
                onTap: () {
                  homeBloc.onDishStyle(1);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Marina',
                    homeBloc.dishStyle == 1
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDishStyle(2);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Fusión',
                    homeBloc.dishStyle == 2
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDishStyle(3);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Peruana',
                    homeBloc.dishStyle == 3
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDishStyle(4);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'China',
                    homeBloc.dishStyle == 4
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDishStyle(5);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Japonesa',
                    homeBloc.dishStyle == 5
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
            ],
          ),
        )
      ],
    );
  }

  _dishBox(String dishType, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, top: 6.0, bottom: 6.0, right: 24.0),
        child: Text(dishType, style: textChipStyle),
      ),
    );
  }
}
