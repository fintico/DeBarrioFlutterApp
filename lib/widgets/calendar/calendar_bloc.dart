import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarBloc extends ChangeNotifier {
  DateTime dayView = DateTime.now().subtract(Duration(hours: 5));
  List<bool> values = List.filled(7, false);

  Color shapeColor = DBColors.WHITE;

  CalendarController calendarController = CalendarController();

  String _dateFormated = '';

  final formatter = new DateFormat.yMMMMEEEEd('es');

  void onViewDay(DateTime dateView) {
    dayView = dateView;
    values = List.filled(7, false, growable: false)
      ..[dayView.weekday % 7] = true;
    shapeColor = DBColors.GRAY_3;
    _dateFormated = formatter.format(dayView);
    notifyListeners();
  }

  void onDay(int day) {
    values = List.filled(7, false, growable: false)..[day % 7] = true;
    shapeColor = DBColors.GRAY_3;
    calendarController.displayDate =
        dayView.subtract(Duration(days: dayView.weekday - day));
    _dateFormated = formatter.format(dayView);
    notifyListeners();
  }

  get dateFormated {
    return _dateFormated;
  }

  set dateFormated(DateTime date) {
    _dateFormated = formatter.format(dayView);
  }
}
