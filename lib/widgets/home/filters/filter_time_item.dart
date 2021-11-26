import 'package:debarrioapp/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'filter_style.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    DateTime today = DateTime.now().subtract(Duration(hours: 5));
    /* Future.delayed(Duration.zero, () async {
      homeBloc.onDayTime(0);
    }); */
    //print(todayString);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 24.0),
          child: Text('FECHAS', style: titleSectionFilterStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 12.0),
          child: Wrap(
            spacing: 37.0,
            runSpacing: 16.0,
            children: <Widget>[
              InkWell(
                onTap: () {
                  //todayString = formatterTo.format(today);
                  homeBloc.onDayTime(0);
                },
                child: _todayBox(homeBloc),
              ),
              InkWell(
                onTap: () {
                  //DateTime time = today.add(Duration(days: 1));
                  //todayString = formatterTo.format(time);
                  //print(todayString);
                  homeBloc.onDayTime(1);
                },
                child: _dateBox(today, 1, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(2);
                },
                child: _dateBox(today, 2, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(3);
                },
                child: _dateBox(today, 3, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(4);
                },
                child: _dateBox(today, 4, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(5);
                },
                child: _dateBox(today, 5, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(6);
                },
                child: _dateBox(today, 6, homeBloc),
              ),
              InkWell(
                onTap: () {
                  homeBloc.onDayTime(7);
                },
                child: _dateBox(today, 7, homeBloc),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _todayBox(HomeBloc homeBloc) {
    return Container(
      height: 56.0,
      width: 56.0,
      decoration: BoxDecoration(
        color: homeBloc.day == 0 ? DBColors.YELLOW : DBColors.WHITE,
        borderRadius: BorderRadius.circular(4.0),
        border: homeBloc.day == 0
            ? null
            : Border.all(color: DBColors.GRAY_3, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 16.0, bottom: 16.0, right: 12.0),
        child:
            Text('Hoy', style: homeBloc.day == 0 ? todayStyle : todayInvStyle),
      ),
    );
  }

  _dateBox(DateTime date, int dayNumber, HomeBloc homeBloc) {
    final formatterDay = new DateFormat('EEE', 'es');
    final formatterMonth = new DateFormat('dd MMM', 'es');
    DateTime time = date.add(Duration(days: dayNumber));
    String day = formatterDay.format(time);
    String month = formatterMonth.format(time);
    String t;
    return Container(
      height: 56.0,
      width: 56.0,
      decoration: BoxDecoration(
        color: homeBloc.day == dayNumber ? DBColors.YELLOW : DBColors.WHITE,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: DBColors.GRAY_3, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              toBeginningOfSentenceCase(day)!,
              style: homeBloc.day == dayNumber ? dayInvStyle : dayStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              month,
              style: homeBloc.day == dayNumber ? monthInvStyle : monthStyle,
            ),
          ),
        ],
      ),
    );
  }
}
