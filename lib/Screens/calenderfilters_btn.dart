import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_five.dart';
import 'package:debarrioapp/widgets/components/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'calender_timeline.dart';

class CalenderFilter extends StatefulWidget {
  final List<PostedDish> postedDishes;
  final List<User> restaurants;

  const CalenderFilter({Key key, this.postedDishes, this.restaurants})
      : super(key: key);

  @override
  _CalenderFilterState createState() => _CalenderFilterState();
}

class _CalenderFilterState extends State<CalenderFilter> {
  User user;
  var _isActive = false;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    final appBar = PreferredSize(
      child: AppBarOptionFive(
        leftIconAction: () => Navigator.pop(context),
        headerTitle: 'Filtra tu calendario',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: DBColors.WHITE,
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
/*                 Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ), */
                /* Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 32.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Filtra tu calendario",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900])),
                ),
                Divider(
                  thickness: 1,
                  indent: 32.0,
                  endIndent: 100.0,
                ),
                Container(
                  child: RadioListTile(
                    title: Text('Ver Todo'),
                    value: true,
                    onChanged: (valor) {},
                    groupValue: false,
                  ),
                ),
                Container(
                  child: CheckboxListTile(
                    title: Text('Ver Todo'),
                    value: true,
                    onChanged: (valor) {},
                  ),
                ),*/
                Divider(
                  thickness: 1,
                  //indent: 28.0,
                  //endIndent: 28.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RadioListTitleButton(
                  action: () {
                    setState(() {
                      print('btn $_isActive');
                      _isActive = true;
                      print(_isActive);
                    });
                  },
                  title: 'Ver Todo',
                  isActive: _isActive,
                ),
                Divider(
                  thickness: 1,
                  indent: 28.0,
                  endIndent: 28.0,
                  color: DBColors.GRAY_5,
                ),
                RadioListTitleButton(
                  action: () {},
                  title: 'Ofertas de Barrio',
                  isActive: _isActive,
                ),
                Divider(
                  thickness: 1,
                  indent: 28.0,
                  endIndent: 28.0,
                  color: DBColors.GRAY_5,
                ),
                RadioListTitleButton(
                  action: () {},
                  title: 'Mis publicaciones',
                  isActive: _isActive,
                ),
                Divider(
                  thickness: 1,
                  indent: 28.0,
                  endIndent: 28.0,
                  color: DBColors.GRAY_5,
                ),
                /* Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CalendarTimeline(
                                  widgetPostedDishes: widget.postedDishes,
                                  widgetRestaurants: widget.restaurants,
                                )));
                  },
                  child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                child: Text(
                                  'Ver Todo',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CalendarTimeline(
                                  widgetPostedDishes: widget.postedDishes
                                      .where((element) =>
                                          element.makerId != user.id)
                                      .toList(),
                                  widgetRestaurants: widget.restaurants
                                      .where((element) => element.id != user.id)
                                      .toList(),
                                )));
                  },
                  child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                child: Text(
                                  'Ofertas De Barrio',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CalendarTimeline(
                                  widgetPostedDishes: widget.postedDishes
                                      .where((element) =>
                                          element.makerId == user.id)
                                      .toList(),
                                  widgetRestaurants: widget.restaurants
                                      .where((element) => element.id == user.id)
                                      .toList(),
                                )));
                  },
                  child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                child: Text(
                                  'Mis Ventas',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), */
              ],
            )),
      ),
    );
  }

  void isActiveFirst() {
    setState(() {
      print(_isActive);
      _isActive = true;
      print(_isActive);
    });
  }
}
