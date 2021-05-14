import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'calendar_bloc.dart';
import 'calendar_style.dart';

class CalendarDay extends StatelessWidget {
  const CalendarDay({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final calendarBloc = Provider.of<CalendarBloc>(context, listen: false);
    final dishProvider = Provider.of<DishProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 84.0),
      child: SfCalendar(
        backgroundColor: DBColors.WHITE,
        view: CalendarView.day,
        controller: calendarBloc.calendarController,
        allowViewNavigation: false,
        cellBorderColor: DBColors.GRAY_13,
        onTap: (calendarTapDetails) {
          print('aea');
        },
        onViewChanged: (details) async {
          await Future.delayed(Duration(seconds: 0));
          List<DateTime> dates = details.visibleDates;

          calendarBloc.onViewDay(dates[0]);
        },
        dataSource: getCalendarDataSource(dishProvider),
        headerHeight: 0.0,
        timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 7,
            timeInterval: Duration(minutes: 60),
            timeIntervalHeight: 40.0,
            timeTextStyle: timeSlot),
        appointmentTextStyle: dishTitleStyle,
      ),
    );
  }

  void viewSet(List<DateTime> dates) {}

  getCalendarDataSource(DishProvider dishProvider) {
    return DataSource(dishProvider.list);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<DishModel> dishes) {
    appointments = dishes;
  }

  @override
  DateTime getStartTime(int index) {
    String date = appointments[index].deliveryDate +
        ' ' +
        appointments[index].deliveryTimeFrom;
    return DateTime.parse(date);
  }

  @override
  Color getColor(int index) {
    return DBColors.GRAY_4;
  }

  @override
  String getSubject(int index) {
    return appointments[index].dishName;
  }

  @override
  DateTime getEndTime(int index) {
    String date = appointments[index].deliveryDate +
        ' ' +
        appointments[index].deliveryTimeTo;
    return DateTime.parse(date);
  }
}

/* DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 11, 10, 00, 00),
      endTime: DateTime.utc(2021, 05, 11, 12, 00, 00),
      isAllDay: false,
      subject: 'La Buena Sazón',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 11, 08, 00, 00),
      endTime: DateTime.utc(2021, 05, 11, 09, 00, 00),
      isAllDay: false,
      subject: 'Don Lucho',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 11, 08, 00, 00),
      endTime: DateTime.utc(2021, 05, 11, 10, 00, 00),
      isAllDay: false,
      subject: 'Don Lucho',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 11, 08, 00, 00),
      endTime: DateTime.utc(2021, 05, 11, 09, 00, 00),
      isAllDay: false,
      subject: 'Don Lucho',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 12, 08, 00, 00),
      endTime: DateTime.utc(2021, 05, 12, 09, 00, 00),
      isAllDay: false,
      subject: 'Don Lucho',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );
  appointments.add(
    Appointment(
      startTime: DateTime.utc(2021, 05, 12, 15, 00, 00),
      endTime: DateTime.utc(2021, 05, 12, 17, 00, 00),
      isAllDay: false,
      subject: 'La Buena Sazón',
      color: DBColors.GRAY_4,
      startTimeZone: '',
      endTimeZone: '',
    ),
  );

  return DataSource(appointments);
} */
