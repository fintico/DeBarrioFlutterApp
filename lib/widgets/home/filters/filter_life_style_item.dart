import 'package:flutter/material.dart';

import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'filter_style.dart';

class LifeStyleItem extends StatelessWidget {
  const LifeStyleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 23.0),
          child: Text('ESTILO DE VIDA', style: titleSectionFilterStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 28.0, right: 28.0, top: 12.0, bottom: 10.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 16.0,
            children: <Widget>[
              InkWell(
                onTap: () {
                  homeBloc.onLifeStyle(1);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Carnívoro',
                    homeBloc.lifeStyle == 1
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onLifeStyle(2);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Vegetariano',
                    homeBloc.lifeStyle == 2
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onLifeStyle(3);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Vegano',
                    homeBloc.lifeStyle == 3
                        ? DBColors.GRAY_7
                        : DBColors.GRAY_6),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onLifeStyle(4);
                },
                borderRadius: BorderRadius.circular(14.0),
                child: _dishBox(
                    'Sin gluten',
                    homeBloc.lifeStyle == 4
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
