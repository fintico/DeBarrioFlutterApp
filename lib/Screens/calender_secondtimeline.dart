import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The app which hosts the home page which contains the calendar on it.

/// The hove page which hosts the calendar
class CalendarSecTimeline extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarSecTimeline({Key key}) : super(key: key);

  @override
  _CalendarSecTimelineState createState() => _CalendarSecTimelineState();
}

class _CalendarSecTimelineState extends State<CalendarSecTimeline> {
  bool loading = true;
  List<PostedDish> currentDishes = [];
  DatabaseService database = DatabaseService();
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      database.getAllPostedDishes().listen((event) {
        currentDishes = [];
        currentDishes.addAll(event);
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.black87,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage("assets/images/Logo.png"),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          iconSize: 35,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      centerTitle: true,
      bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 0.8,
                color: Colors.white,
                endIndent: 22.0,
                indent: 22,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    "Donde te encuentras?",
                    style: TextStyle(
                      color: Colors.yellowAccent[700],
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: HexColor("#f2f2f2"),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey[200]),
        ),
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: () {},
          child: Text("Continuar"),
          color: Colors.redAccent,
        ),
      ),
      body: LoadingOverlay(
        isLoading: loading,
        child: loading
            ? SizedBox(
                height: 20,
              )
            : Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
                width: (MediaQuery.of(context).size.width),
                child: Container(
                  height: (MediaQuery.of(context).size.height),
                  width: (MediaQuery.of(context).size.width),
                  child: SfCalendar(
                    onTap: (calendarTapDetails) {
                      if (cZeroStr(calendarTapDetails.appointments)) {
                        PostedDish posted = calendarTapDetails.appointments[0];
                        print(posted);
                      }
                    },
                    backgroundColor: Colors.grey[200],
                    view: CalendarView.week,
                    dataSource: getCalendarDataSource(),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      timeInterval: Duration(minutes: 120),
                      timeIntervalHeight: 80,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  getCalendarDataSource() {
    return FoodTimingSource(currentDishes);
  }
}

class FoodTimingSource extends CalendarDataSource {
  FoodTimingSource(List<PostedDish> currentList) {
    appointments = [];
    appointments.addAll(currentList);
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }
  // @override
  // String getLocation(int index) {
  //   return appointments[index].currentLocation;
  // }

  // @override
  // String getNotes(int index) {
  //
  // }
  @override
  Color getColor(int index) {
    return Colors.redAccent;
  }

  @override
  String getSubject(int index) {
    return appointments[index].name;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endTime;
  }
}
