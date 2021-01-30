import 'package:da_brello_ui/ModelClass/PostedDishModel.dart';
import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/ModelClass/foodData.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../utilsFunctions.dart';
import 'calender_info_add_new_dish_to_publish.dart';
import 'calenderfilters_btn.dart';
import 'food_carousel.dart';

/// The app which hosts the home page which contains the calendar on it.

/// The hove page which hosts the calendar
class CalendarTimeline extends StatefulWidget {
  final List<PostedDish> widgetPostedDishes;
  final List<User> widgetRestaurants;

  const CalendarTimeline({Key key, this.widgetPostedDishes, this.widgetRestaurants}) : super(key: key);
  /// Creates the home page to display teh calendar widget.

  @override
  _CalendarTimelineState createState() => _CalendarTimelineState();
}

class _CalendarTimelineState extends State<CalendarTimeline> {
  List<PostedDish> postedDishes;
  List<User> restaurants;
  FoodData foodData;

  @override
  void initState() {
    super.initState();
    setCurrentList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(postedDishes.length==0){
        setState(() {
          postedDishes.addAll(foodData.dishesData);
          restaurants.addAll(foodData.restaurantData);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    foodData=Provider.of<FoodData>(context);
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
          icon: Icon(Icons.settings),
           onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CalenderFilter(postedDishes: postedDishes,restaurants: restaurants,)))
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
                    "Calendario",
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
          onPressed: () { Navigator.push(
              context, MaterialPageRoute(builder: (_) => CalenderFill()));

          },
          child: Text("Quiero Vender"),
          color: Colors.redAccent,
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        width: (MediaQuery.of(context).size.width),
        child: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          child: SfCalendar(
            backgroundColor: Colors.grey[200],
            view: CalendarView.week,
            dataSource: getCalendarDataSource(),
            onTap:(calendarTapDetails) {
              if(cZeroStr(calendarTapDetails.appointments)) {
                PostedDish posted = calendarTapDetails.appointments[0];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantCarouselSlider(postedDishes:postedDishes.where((element) => element.makerId==posted.makerId).toList(),selectedRestaurant: restaurants[restaurants.indexWhere((element) => element.id==posted.makerId)],),
                  ),
                );
              }
            } ,
            timeSlotViewSettings: TimeSlotViewSettings(
              timeInterval: Duration(minutes: 120),
              timeIntervalHeight: 80,
            ),
          ),
        ),
      ),
    );
  }

  getCalendarDataSource() {
    return FoodTimingSource(postedDishes);
  }

  void setCurrentList() {
    postedDishes=widget.widgetPostedDishes??[];
    restaurants=widget.widgetRestaurants??[];
  }
}
class FoodTimingSource extends CalendarDataSource{
  FoodTimingSource(List<PostedDish> currentList){
    appointments=[];
    appointments.addAll(currentList);
  }


  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }
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
