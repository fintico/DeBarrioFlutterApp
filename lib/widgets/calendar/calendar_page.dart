import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/calendar/calendar_bloc.dart';
import 'package:debarrioapp/widgets/calendar/calendar_header.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_four.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/dish/dish_publish_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:weekday_selector/weekday_selector.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

import 'calendar_alert_seller.dart';
import 'calendar_day.dart';
import 'calendar_style.dart';
import 'calendar_week.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    final appBar = PreferredSize(
      child: AppBarOptionFour(
        leftIconAction: () => Navigator.pop(context),
        rightIconAction: () {},
        headerTitle: 'Calendario',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: Stack(
            children: [
              CalendarDay(),
              CalendarHeader(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          child: GenericButtonOrange(
            text: '¡QUIERO VENDER!',
            disable: false,
            action: () {
              if (homeBloc.sellerAddress!.seller!.restaurantName != null) {
                Navigator.push(
                    //context, MaterialPageRoute(builder: (_) => CalenderFill()));
                    context,
                    MaterialPageRoute(builder: (_) => DishPublish()));
              } else {
                print('no hay perfil');

                /* return showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext) {
                    return CalendarAlertSeller();
                  },
                ); */
              }
            },
          ),
        ),
      ),
    );
  }
}
