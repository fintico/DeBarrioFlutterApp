import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da_brello_ui/ModelClass/PostedDishModel.dart';
import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Screens/fullproductinfo.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:da_brello_ui/Wideget_CalenderInfo_Screen/DateTime.dart';
import 'package:da_brello_ui/Wideget_CalenderInfo_Screen/DropDownCategories.dart';
import 'package:da_brello_ui/Wideget_CalenderInfo_Screen/bottomBar.dart';
import 'package:da_brello_ui/utilsFunctions.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'dish.dart';

class CalenderFill extends StatefulWidget {
  @override
  _CalenderFillState createState() => _CalenderFillState();
}

class _CalenderFillState extends State<CalenderFill> {
  // ignore: unused_field
  String _myCategoria;
  GeoPoint _myLoc = GeoPoint(0.0, 0);
  String _myHasla;
  String _myDesde;
  bool nameError = false,
      totalServiceError = false,
      originalPrice = false,
      deliveryPrice = false;
  User user;
  PostedDish postedDish = PostedDish();
  DatabaseService database = DatabaseService();
  final formKey = new GlobalKey<FormState>();
  List<String> dayTime = [
    '12 AM',
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM'
  ];

  @override
  void initState() {
    super.initState();
    _myCategoria = '';
    _myHasla = '';
    _myDesde = '';
  }

  bool init = false;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (!init) {
      postedDish = Provider.of<PostedDish>(context);
      postedDish.currentLocation = user.address[0].addressLanLon;
      init = true;
    }

    TextStyle _fieldsStyle =
        TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold);
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
      backgroundColor: HexColor("#f2f2f2"),
      bottomNavigationBar: BottomBarCalenderInfo(setPostedDish: setPostedDish),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Plato a vender",
                    textAlign: TextAlign.start,
                    style: _fieldsStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 10.0),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.name,

                      onChanged: (value) => postedDish.name = value,
                      decoration: InputDecoration(
                        hintText: "Nombre Del Plato ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                DropDownCategory(
                  setCategory: setCategory,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Stock de porciones",
                    textAlign: TextAlign.start,
                    style: _fieldsStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 10.0),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) => postedDish.totalService = value,
                      decoration: InputDecoration(

                        hintText: "Numero de porciones",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Fetcha de la venta",
                    textAlign: TextAlign.start,
                    style: _fieldsStyle,
                  ),
                ),
                CalenderInfoDate(setDateToSell: setDateToSell),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 10.0),
                        child: Text(
                          "Horario",
                          textAlign: TextAlign.left,
                          style: _fieldsStyle,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        new Flexible(
                          child: new Padding(
                            padding: const EdgeInsets.only(
                                left: 32.0, right: 24.0, top: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropDownFormField(
                                  required: true,
                                  filled: false,
                                  titleText: "Desde",
                                  hintText: 'Desde',
                                  value: _myDesde,
                                  onSaved: (value) {
                                    setState(() {
                                      _myDesde = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myDesde = value;
                                    });
                                  },
                                  dataSource: dayTime
                                      .map((e) => {
                                            "display": e,
                                            "value":
                                                dayTime.indexOf(e).toString(),
                                          })
                                      .toList(),
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Flexible(
                          child: new Padding(
                            padding: const EdgeInsets.only(
                                left: 32.0, right: 24.0, top: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropDownFormField(
                                  filled: false,
                                  titleText: "Hasla",
                                  hintText: 'Hasla',
                                  value: _myHasla,
                                  onSaved: (value) {
                                    setState(() {
                                      _myHasla = value;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _myHasla = value;
                                    });
                                  },
                                  dataSource: dayTime
                                      .map((e) => {
                                            "display": e,
                                            "value":
                                                dayTime.indexOf(e).toString(),
                                          })
                                      .toList(),
                                  textField: 'display',
                                  valueField: 'value',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "Precio con delivery(por porcion)",
                        textAlign: TextAlign.start,
                        style: _fieldsStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      child: Container(
                        child: TextField(
                          onChanged: (value) =>
                              postedDish.originalPrice = value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            prefixText: "S/",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "Precio con recojo (por porcion)",
                        textAlign: TextAlign.start,
                        style: _fieldsStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      child: Container(
                        child: TextField(
                          onChanged: (value) =>
                              postedDish.priceWithDelivery = value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            prefixText: "S/",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownFormField(
                            filled: false,
                            titleText: 'Ubicaion actual',
                            hintText: user.address[0].addressString,
                            value: postedDish.currentLocation,
                            onChanged: (value) {
                              setState(() {
                                postedDish.currentLocation = value;
                              });
                            },
                            dataSource: user.address
                                .map(
                                  (e) => {
                                    "display": e.addressString,
                                    "value": e.addressLanLon,
                                  },
                                )
                                .toList(),
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setDateToSell(String value) {
    postedDish.salesDate = DateTime.parse(value);
  }

  void setCategory(String category) {
    postedDish.category = category;
  }

  Future<void> setPostedDish() async {
    if (!cZeroStr(postedDish.name)) {
      Fluttertoast.showToast(
          msg: "Please select a dish name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (!cZeroStr(postedDish.totalService)) {
      Fluttertoast.showToast(
          msg: "Please select total dish service",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (!cZeroStr(postedDish.priceWithDelivery)) {
      Fluttertoast.showToast(
          msg: "Please set delievery price",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (!cZeroStr(postedDish.originalPrice)) {
      Fluttertoast.showToast(
          msg: "Please set dish price on pickUp",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    postedDish.id = await database.getRandomId();
    postedDish.makerId = user.id;
    postedDish.status = 'Completed';
    postedDish.startTime = DateTime(
        postedDish.salesDate.year,
        postedDish.salesDate.month,
        postedDish.salesDate.day,
        int.parse(_myDesde));
    postedDish.endTime = DateTime(
        postedDish.salesDate.year,
        postedDish.salesDate.month,
        postedDish.salesDate.day,
        int.parse(_myHasla));

    if (postedDish.startTime.isAfter(postedDish.endTime)) {
      Fluttertoast.showToast(
          msg: "Please select end time which is after start time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (postedDish.currentLocation == null) {
      Fluttertoast.showToast(
          msg: "Please select Location for the dish ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    postedDish.salesNumber = postedDish.id.substring(postedDish.id.length - 5);
    database.setPostedDishData(postedDish);
    postedDish.additionDish=[];
    postedDish.notifyListeners();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Dish()));
  }
}
