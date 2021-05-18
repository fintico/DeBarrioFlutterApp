import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/fullproductinfo.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/Wideget_CalenderInfo_Screen/DateTime.dart';
import 'package:debarrioapp/Wideget_CalenderInfo_Screen/DropDownCategories.dart';
import 'package:debarrioapp/Wideget_CalenderInfo_Screen/bottomBar.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_four.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:debarrioapp/widgets/components/icons/calendar.dart';
import 'package:debarrioapp/widgets/components/radio_button.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:intl/intl.dart';
import '../utilProperties.dart';

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
  /* List<String> dayTime = [
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
  ]; */

  String dishName;
  String categoryName;
  String saleDate;
  String fromTime;
  String toTime;
  int fromTimeIndex;
  int toTimeIndex;

  @override
  void initState() {
    super.initState();
    _myCategoria = '';
    _myHasla = '';
    _myDesde = '';
    dishName = '';
    validator();
  }

  bool init = false;

  TextStyle labelInput = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0.0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );
  TextStyle subTitleStyle = DBStyle.getStyle(
    DBStyle.GRAY_1,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0.0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );
  TextStyle buttonStyle = DBStyle.getStyle(
    DBStyle.WHITE,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0.0,
    DBStyle.FONT_WEIGHT_BOLD,
  );
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
    /* final appBar = AppBar(
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
    ); */
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Publicar venta',
          leftIconAction: () => Navigator.pop(context),
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.WHITE,
        bottomNavigationBar:
            //BottomBarCalenderInfo(setPostedDish: setPostedDish),
            /* Padding(
          padding: const EdgeInsets.all(28.0),
          child: GenericButtonOrange(
            text: 'PUBLICAR VENTA',
            disable: validator(),
            action: () {},
          ),
        ) */
            Padding(
          padding: const EdgeInsets.all(28.0),
          child: elevatedButton(),
        ),
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
                  /* Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ), */
                  _dishName(),
                  _categoryName(),
                  /* Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Plato a vender",
                      textAlign: TextAlign.start,
                      style: _fieldsStyle,
                    ),
                  ), */
                  /* Padding(
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
                  ), */
                  /* DropDownCategory(
                    setCategory: setCategory,
                  ), */
                  _stockNumber(),
                  _dateSale(),
                  /* Container(
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
                  ), */
                  /* Padding(
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
                  ), */
                  /* Container(
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
                  ), */
                  //CalenderInfoDate(setDateToSell: setDateToSell),
                  _deliveryTime(),
                  _priceByDelivery(),
                  _priceByPickUp(),
                  _salesAddress(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  /* Column(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
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
                                        print(_myDesde);
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
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
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
                      /* Container(
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
                      ), */

                      /* Container(
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
                      ), */
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
                  ), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dishName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => postedDish.name = value,
        onTap: () => validator(),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Nombre del plato',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Nombre del plato',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        readOnly: true,
        onTap: () => categoryBottomSheet(context),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: categoryName,
          hintStyle: TextStyle(
            color: cZeroStr(categoryName) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Categoría',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(categoryName) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _stockNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => postedDish.totalService = value,
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Stock de porciones',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Stock de porciones',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateSale() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onTap: () {
          _selectDate(context);
        },
        readOnly: true,
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: saleDate,
          hintStyle: TextStyle(
            color: cZeroStr(saleDate) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Fecha de entrega',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(saleDate) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CalendarIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _deliveryTime() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Horario de entrega',
              style: subTitleStyle,
            ),
          ),
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Expanded(
                    child: _fromTime(),
                  ),
                ),
                Container(
                  child: Expanded(
                    child: _toTime(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fromTime() {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0),
      padding: const EdgeInsets.only(right: 20.0, top: 15.0, bottom: 15.0),
      child: TextField(
        readOnly: true,
        onTap: () => fromTimeBottomSheet(context),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: fromTime,
          hintStyle: TextStyle(
            color: cZeroStr(fromTime) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Desde',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(fromTime) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _toTime() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15.0),
      child: TextField(
        readOnly: true,
        onTap: () => toTimeBottomSheet(context),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: toTime,
          hintStyle: TextStyle(
            color: cZeroStr(toTime) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Hasta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(toTime) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceByDelivery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => postedDish.originalPrice = value,
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Precio con delivery (por porción)',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Precio con delivery (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          fillColor: DBColors.GREEN,
          prefixText: "S/",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceByPickUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => postedDish.priceWithDelivery = value,
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Precio con recojo (por porción)',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Precio con recojo (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          fillColor: DBColors.GREEN,
          prefixText: "S/",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _salesAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        readOnly: true,
        //onTap: () => categoryBottomSheet(context),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: user.address[0].addressString,
          hintStyle: TextStyle(
            color: cZeroStr(user.address[0].addressString)
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Dirección para la venta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: cZeroStr(user.address[0].addressString)
              ? FloatingLabelBehavior.always
              : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget elevatedButton() {
    return SizedBox(
      height: 48.0,
      child: ElevatedButton(
        onPressed: () => setPostedDish(),
        child: Text(
          'PUBLICAR VENTA',
          style: buttonStyle,
        ),
        style: ElevatedButton.styleFrom(
          primary: DBColors.RED,
          side: BorderSide(color: DBColors.RED),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
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
        //int.parse(_myDesde));
        fromTimeIndex);
    postedDish.endTime = DateTime(postedDish.salesDate.year,
        postedDish.salesDate.month, postedDish.salesDate.day, toTimeIndex);
    //int.parse(_myHasla));

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
    postedDish.additionDish = [];
    postedDish.notifyListeners();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => DishConfirm()));
  }

  void categoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Categoría'),
                ),
                Divider(),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final categoryList = category[index];
                      return Container(
                        child: RadioListTitleButton(
                          action: () {
                            setState(() {
                              categoryName = categoryList;
                              postedDish.category = categoryList;
                            });
                            print(categoryName);
                            Navigator.of(context).pop();
                          },
                          title: '$categoryList',
                          isActive: false,
                        ),
                      );
                    },
                    itemCount: category.length,
                  ),
                )
              ],
            ),
          );
        });
  }

  void fromTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Desde'),
                ),
                Divider(),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final time = dayTime[index];
                      return Container(
                        child: RadioListTitleButton(
                          action: () {
                            setState(() {
                              fromTime = time;
                              fromTimeIndex = index;
                              //postedDish.startTime = time.da;
                            });
                            print(fromTime);
                            Navigator.of(context).pop();
                          },
                          title: '$time',
                          isActive: false,
                        ),
                      );
                    },
                    itemCount: dayTime.length,
                  ),
                )
              ],
            ),
          );
        });
  }

  void toTimeBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Hasta'),
                ),
                Divider(),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final time = dayTime[index];
                      return Container(
                        child: RadioListTitleButton(
                          action: () {
                            setState(() {
                              toTime = time;
                              toTimeIndex = index;
                              //postedDish.category = time;
                            });
                            print(toTime);
                            Navigator.of(context).pop();
                          },
                          title: '$time',
                          isActive: false,
                        ),
                      );
                    },
                    itemCount: dayTime.length,
                  ),
                )
              ],
            ),
          );
        });
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2030),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      var formatter = new DateFormat('dd/MM/yyyy');
      setState(() {
        saleDate = formatter.format(picked);
        //postedDish.salesDate = DateTime.parse(picked);
        postedDish.salesDate = picked;
      });
    }
  }

  bool validator() {
    bool state = true;
    print(postedDish.name);
    print(cZeroStr(postedDish.name));
    if (cZeroStr(postedDish.name)) {
      setState(() {
        state = false;
      });
      print('1');
    } else {
      print('2');
      state = true;
    }
    return state;
  }
}
