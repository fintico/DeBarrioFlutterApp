import 'package:debarrioapp/widgets/calendar/calendar_week.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'calendar_bloc.dart';
import 'calendar_style.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarBloc = Provider.of<CalendarBloc>(context);
    return Container(
      //padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      height: screenHeight(context, dividedBy: 4.3),
      color: DBColors.WHITE,
      child: Column(
        children: [
          CalendarWeek(),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
            child: Divider(
              color: DBColors.GRAY_4,
              thickness: 1.0,
              height: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 23.0),
            child: Text(
              '${calendarBloc.dateFormated}',
              style: dateStyle,
            ),
          ),
        ],
      ),
    );
  }
}
