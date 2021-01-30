import 'package:da_brello_ui/ModelClass/PostedDishModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calender_timeline.dart';
import 'fullproductinfo.dart';
import 'map_screen.dart';

class Dish extends StatefulWidget {
  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<Dish> {
  PostedDish postedDish;
  @override
  Widget build(BuildContext context) {
    postedDish=Provider.of<PostedDish>(context);
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
      centerTitle: true,
    );
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.2,
                    image: AssetImage("assets/images/dish.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Text(
                    "Tu venta esta lista",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.yellow[600],
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    "Ahora espera per los pedidos,sigue" "con esas ganas",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  child: Text(
                    "N de venta ${postedDish.salesNumber}",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Container(
                  child: Text(
                    "Recuerda que puedes revisor el estado de tu",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                 Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CalendarTimeline()),(Route<dynamic> route)=>false);
                        },
                        child: Text("Calendario"),
                        color: Colors.grey[300],
                        elevation: 0.0,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () { Navigator.push(
                            context, MaterialPageRoute(builder: (_) => FullInfoProd()));},
                        child: Text("Confirmar venta"),
                        elevation: 0.0,
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              ],
            )),
      ),
    );
  }
}
