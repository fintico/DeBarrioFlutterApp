/* import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AfterRadioCarousal extends StatelessWidget {
  final PostedDish postedDish;

  AfterRadioCarousal(this.postedDish);

  Widget _fechasButton(String text, Color color, Color bordercolor) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {},
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      color: color,
      textColor: Colors.black,
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: new Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 32.0, bottom: 10),
                    child: Text(
                      "Fechas desponibles",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Busca por la fetcha",
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          child:
                              _fechasButton("Hoy", Colors.amber, Colors.amber),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 1)))}",
                              Colors.white,
                              Colors.black),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 2)))}",
                              Colors.white,
                              Colors.black),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 3)))}",
                              Colors.white,
                              Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RaisedButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () => {Navigator.pop(context)},
                          child: Text(
                            "Acceptar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      "Entrega",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Text(
                    "Disponibillidad",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        Icon(Icons.timer_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                              "${DateFormat('hh:mm a').format(postedDish.startTime)} - ${DateFormat('hh:mm a').format(postedDish.endTime)}"),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.7,
                    child: RaisedButton.icon(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      label: Text(
                        "Hoy",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      hoverColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          if (cZeroStr(postedDish.additionDish))
            Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: Text(
                      "Adicionales",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
 */
