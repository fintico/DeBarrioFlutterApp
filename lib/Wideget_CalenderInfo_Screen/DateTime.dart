import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class CalenderInfoDate extends StatefulWidget {
  final Function setDateToSell;

  const CalenderInfoDate({Key key, this.setDateToSell}) : super(key: key);
  @override
  _CalenderInfoDateState createState() => _CalenderInfoDateState();
}

class _CalenderInfoDateState extends State<CalenderInfoDate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
      child: Container(
          child: DateTimePicker(
        decoration: InputDecoration(
          hintText: "29/05/2020",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onChanged: (val) {
          print(val);
          widget.setDateToSell(val);
        },
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) {
          print(val);
        },
      )),
    );
  }
}
