import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'calendar_bloc.dart';
import 'calendar_style.dart';

class CalendarWeek extends StatefulWidget {
  const CalendarWeek({Key key}) : super(key: key);

  @override
  _CalendarWeekState createState() => _CalendarWeekState();
}

class _CalendarWeekState extends State<CalendarWeek> {
  List<bool> values = List.filled(7, false);
  final DateSymbols es = dateTimeSymbolMap()['es_419'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calendarBloc = Provider.of<CalendarBloc>(context);
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      color: DBColors.WHITE,
      child: WeekdaySelector(
        onChanged: (int day) {
          calendarBloc.onDay(day);
        },
        firstDayOfWeek: DateTime.sunday,
        textStyle: dayLetter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        fillColor: DBColors.WHITE,
        hoverColor: DBColors.WHITE,
        focusColor: DBColors.GRAY_3,
        elevation: 0.0,
        shortWeekdays: es.STANDALONENARROWWEEKDAYS,
        values: calendarBloc.values,
        selectedFillColor: calendarBloc.shapeColor,
        selectedTextStyle: daySelectedLetter,
        selectedShape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
