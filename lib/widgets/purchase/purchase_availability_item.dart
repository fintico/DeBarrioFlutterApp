import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'purchase_style.dart';

class PurchaseAvailability extends StatelessWidget {
  const PurchaseAvailability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    DateTime today = DateTime.now().subtract(Duration(hours: 5));
    return Container(
      height: screenHeight(context, dividedBy: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 26.0),
            child: Text(
              'Fechas disponibles',
              style: titleModalStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 8.0),
            child: Text(
              'Busca por la fecha que necesites:',
              style: subtitleModalStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, right: 28.0, top: 20.0),
              child: Wrap(
                spacing: 16.0,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(0);
                    },
                    child: _todayBox(purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(1);
                    },
                    child: _dateBox(today, 1, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(2);
                    },
                    child: _dateBox(today, 2, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(3);
                    },
                    child: _dateBox(today, 3, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(4);
                    },
                    child: _dateBox(today, 4, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(5);
                    },
                    child: _dateBox(today, 5, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(6);
                    },
                    child: _dateBox(today, 6, purchaseBloc),
                  ),
                  InkWell(
                    onTap: () {
                      purchaseBloc.onDayTime(7);
                    },
                    child: _dateBox(today, 7, purchaseBloc),
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 28.0, top: 26.0, right: 28.0),
              child: GenericButtonOrange(
                text: 'ACEPTAR',
                disable: false,
                action: () {
                  purchaseBloc.onSetDateTime(purchaseBloc.day);
                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }

  _todayBox(PurchaseBloc purchaseBloc) {
    return Container(
      height: 56.0,
      width: 56.0,
      decoration: BoxDecoration(
        color: purchaseBloc.day == 0 ? DBColors.YELLOW : DBColors.WHITE,
        borderRadius: BorderRadius.circular(4.0),
        border: purchaseBloc.day == 0
            ? null
            : Border.all(color: DBColors.GRAY_3, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 16.0, bottom: 16.0, right: 12.0),
        child: Text(
          'Hoy',
          style: purchaseBloc.day == 0 ? todayStyle : todayInvStyle,
        ),
      ),
    );
  }

  _dateBox(DateTime date, int dayNumber, PurchaseBloc purchaseBloc) {
    final formatterDay = new DateFormat('EEE', 'es');
    final formatterMonth = new DateFormat('dd MMM', 'es');
    DateTime time = date.add(Duration(days: dayNumber));
    String? day = formatterDay.format(time);
    String month = formatterMonth.format(time);
    return Container(
      height: 56.0,
      width: 56.0,
      decoration: BoxDecoration(
        color: purchaseBloc.day == dayNumber ? DBColors.YELLOW : DBColors.WHITE,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: DBColors.GRAY_3, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              toBeginningOfSentenceCase(day)!,
              style: purchaseBloc.day == dayNumber ? dayInvStyle : dayStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              month,
              style: purchaseBloc.day == dayNumber ? monthInvStyle : monthStyle,
            ),
          ),
        ],
      ),
    );
  }
}
