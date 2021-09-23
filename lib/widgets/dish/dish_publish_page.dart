import 'dart:developer';
import 'dart:io';

import 'package:debarrioapp/ServicesFire/FirebaseStorageService.dart';
import 'package:debarrioapp/models/additionalDish.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:debarrioapp/widgets/components/icons/calendar.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/radio_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../utilProperties.dart';
import '../../utilsFunctions.dart';
import 'dish_location_page.dart';
import 'dish_style.dart';

class DishPublish extends StatefulWidget {
  DishPublish({Key key}) : super(key: key);

  @override
  _DishPublishState createState() => _DishPublishState();
}

class _DishPublishState extends State<DishPublish> {
  StorageService storage = StorageService();

  final picker = ImagePicker();

  String dishName;
  String categoryName;
  String saleDate;
  String saleDateTo;
  String fromTime;
  String toTime;
  int fromTimeIndex;
  int toTimeIndex;
  File _imageFile;
  String urlImage;

  DateTime deliveryDate;
  DateTime dishFromTime;
  DateTime dishToTime;

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Publicar venta',
          leftIconAction: () {
            Navigator.pop(context);
          },
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.BLUE_LIGHT_5,
        bottomNavigationBar: _botomNavBar(),
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            /* height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top, */
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _dishImage(),
                  Container(
                    //height: MediaQuery.of(context).size.height,
                    color: DBColors.WHITE,
                    child: Column(
                      children: [
                        _dishName(),
                        _categoryName(),
                        _stockNumber(),
                        _dateSale(),
                        _deliveryTime(),
                        _priceByDelivery(),
                        _priceByPickUp(),
                        _salesAddress(homeBloc),
                      ],
                    ),
                  ),
                  Container(
                    height: dish.dishAdditional != null
                        ? screenHeight(context, dividedBy: 1.75)
                        : screenHeight(context, dividedBy: 3.3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dishImage() {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context, dividedBy: 4.0),
      color: DBColors.BLUE_LIGHT_5,
      child: cZeroStr(dish.urlImage)
          ? Container(
              padding: const EdgeInsets.all(28.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  dish.dishImageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 52.0),
                  child: SvgPicture.asset(
                    'assets/images/empty.svg',
                    height: 72.0,
                    width: 88.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () => pickDishImage(),
                    child: Text(
                      'AGREGAR FOTO',
                      style: addPhotoStyle,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _dishName() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => dish.dishName = value,
        //onTap: () => validator(),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: dish.dishName != null ? dish.dishName : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Nombre del plato',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(dish.dishName) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _categoryName() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        readOnly: true,
        onTap: () => categoryBottomSheet(context),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: dish.category,
          hintStyle: TextStyle(
            color: cZeroStr(dish.category) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Categoría',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(dish.category) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _stockNumber() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => dish.dishStock = int.parse(value),
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: dish.dishStock != null ? dish.dishStock.toString() : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Stock de porciones',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              dish.dishStock != null ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _dateSale() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
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
          hintText: dish.date,
          hintStyle: TextStyle(
            color: cZeroStr(dish.date) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Fecha de entrega',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(dish.date) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
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
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _deliveryTime() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
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
          hintText: dish.timeFrom,
          hintStyle: TextStyle(
            color: cZeroStr(dish.timeFrom) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Desde',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(dish.timeFrom) ? FloatingLabelBehavior.always : null,
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
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
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
          hintText: dish.timeTo,
          hintStyle: TextStyle(
            color: cZeroStr(dish.timeTo) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: 'Hasta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(dish.timeTo) ? FloatingLabelBehavior.always : null,
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
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _priceByDelivery() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => dish.dishDeliveryPrice = double.parse(value),
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: dish.dishDeliveryPrice != null
              ? "S/ ${dish.dishDeliveryPrice.toString()}"
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Precio con delivery (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: dish.dishDeliveryPrice != null
              ? FloatingLabelBehavior.always
              : null,
          fillColor: DBColors.GREEN,
          prefixText: dish.dishDeliveryPrice != null ? "" : "S/",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _priceByPickUp() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => dish.dishPickUpPrice = double.parse(value),
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: dish.dishPickUpPrice != null
              ? "S/ ${dish.dishPickUpPrice.toString()}"
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Precio con recojo (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: dish.dishPickUpPrice != null
              ? FloatingLabelBehavior.always
              : null,
          fillColor: DBColors.GREEN,
          prefixText: dish.dishPickUpPrice != null ? "" : "S/",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _salesAddress(HomeBloc homeBloc) {
    return Container(
      padding: const EdgeInsets.only(
          left: 28.0, right: 28.0, top: 32.0, bottom: 32.0),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DishLocation(),
            ),
          );
        },
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: homeBloc.sellerAddress.address.address,
          hintStyle: TextStyle(
            color: cZeroStr(
              homeBloc.sellerAddress.address.address,
            )
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Dirección para la venta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(homeBloc.sellerAddress.address.address)
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
          contentPadding: EdgeInsets.only(left: 12.0, top: 13.0, bottom: 13.0),
        ),
      ),
    );
  }

  Widget _botomNavBar() {
    return Container(
      //height: 200.0,
      height: dish.dishAdditional != null
          ? screenHeight(context, dividedBy: 2.225)
          : screenHeight(context, dividedBy: 4.35),
      child: Column(
        children: [
          Container(
            //height: 70.0,
            color: DBColors.GRAY_8,
            child: Column(
              children: [
                dish.dishAdditional != null
                    ? Container(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, top: 32.0, bottom: 16.0),
                              child: Text(
                                'ADICIONALES',
                                style: bNavbarTitleStyle,
                              ),
                            ),
                            Divider(
                              color: DBColors.BLUE_LIGHT_5,
                              thickness: 1.0,
                              indent: 28.0,
                              endIndent: 28.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                /* crossAxisAlignment: CrossAxisAlignment.start, */
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 28.0,
                                          top: 20.0,
                                        ),
                                        child: Text(
                                          dish.dishAdditional != null
                                              ? additionalDish
                                                  .additionalDescription
                                              : "",
                                          style: bNavbarSubTitleStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 28.0,
                                          bottom: 20.0,
                                        ),
                                        child: Text(
                                          dish.dishAdditional != null
                                              ? 'S/ ${additionalDish.price.toString()}'
                                              : "",
                                          style: bNavbarDescriptionStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 28.0,
                                      top: 34.0,
                                      bottom: 34.0,
                                    ),
                                    child: AngleRightIcon(
                                      height: 20.0,
                                      width: 20.0,
                                      color: DBColors.GRAY_2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: DBColors.BLUE_LIGHT_5,
                              thickness: 1.0,
                              indent: 28.0,
                              endIndent: 28.0,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 0.1,
                      ),
                InkWell(
                  onTap: () {
                    Routes.sailor.navigate(Routes.DISH_ADDITIONAL_SCREEN,
                        navigationType: NavigationType.push);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, top: 20.0),
                        child: PlusCircleIcon(
                          height: 16.0,
                          width: 16.0,
                          color: DBColors.GREEN,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 20.0),
                        child: Text(
                          'AGREGAR ADICIONAL',
                          style: addAdditionalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Divider(
                  color: DBColors.BLUE_LIGHT_5,
                  thickness: 1.0,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                SizedBox(
                  height: 6.0,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 28.0, right: 28.0, top: 20, bottom: 24.0),
            width: screenWidth(context),
            height: 92.0,
            color: DBColors.WHITE,
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
          ),
        ],
      ),
    );
  }

  void setDateToSell(String value) {
    //  postedDish.salesDate = DateTime.parse(value);
  }

  void setCategory(String category) {
    // postedDish.category = category;
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
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 15.0, bottom: 15.0),
                  child: Text(
                    'Categoría',
                    style: bottonModalStyle,
                  ),
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
                              dish.category = categoryList;
                              dish.dishCategory = index + 1;
                            });
                            print(categoryName);
                            print(index);
                            print(dish.dishCategory);
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
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 15.0, bottom: 15.0),
                  child: Text(
                    'Desde',
                    style: bottonModalStyle,
                  ),
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
                              dish.timeFrom = time;
                              print(fromTimeIndex);
                              //postedDish.startTime = time.da;
                            });
                            dishFromTime = DateTime(
                                deliveryDate.year,
                                deliveryDate.month,
                                deliveryDate.day,
                                fromTimeIndex);
                            var timeFormatter = new DateFormat('H:mm');
                            dish.dishDeliveryFromTime =
                                timeFormatter.format(dishFromTime);
                            print(dishFromTime);
                            print(dish.dishDeliveryFromTime);
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
                  padding: const EdgeInsets.only(
                      left: 28.0, top: 15.0, bottom: 15.0),
                  child: Text(
                    'Hasta',
                    style: bottonModalStyle,
                  ),
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
                              dish.timeTo = time;
                              dishToTime = DateTime(
                                  deliveryDate.year,
                                  deliveryDate.month,
                                  deliveryDate.day,
                                  toTimeIndex);
                              var timeFormatter = new DateFormat('H:mm');
                              dish.dishDeliveryToTime =
                                  timeFormatter.format(dishToTime);
                              print(dish.dishDeliveryToTime);
                              print(dishToTime);
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
      var formatterTo = new DateFormat('yyyy-MM-dd');
      setState(() {
        saleDate = formatter.format(picked);
        dish.date = formatter.format(picked);
        saleDateTo = formatterTo.format(picked);
        deliveryDate = picked;
        dish.dishDeliveryDate = saleDateTo;
        print(saleDateTo);
        print(picked);
      });
    }
  }

  Future pickDishImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        dish.dishImageFile = _imageFile;
        dish.urlImage = pickedFile.path;
      });
      //uploadImage();
    } else {
      print('nope');
    }
  }

  Future uploadImage() async {
    String fileName = path.basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
      (value) {
        print("Done: $value");
        setState(() {
          urlImage = value;
          dish.urlImage = value;
        });
      },
    );
  }

  Future setPostedDish() async {
    if (!cZeroStr(dish.dishName)) {
      print('Please select a dish name');
      inspect(dish);
      return;
    } else if (dish.dishImageFile == null) {
      print('Please select an image');
      return;
    } else if (dish.dishStock == null) {
      print('Please select a stock');
      return;
    } else if (dish.dishCategory == null) {
      print('Please select a category');
      return;
    } else if (!cZeroStr(dish.dishDeliveryDate)) {
      print('Please select a date');
      return;
    } else if (dish.dishDeliveryPrice == null) {
      print('Please select a delivery price');
      return;
    } else if (dish.dishPickUpPrice == null) {
      print('Please select a pickup price');
      return;
    } else {
      print('ready');
      inspect(dish);
      Routes.sailor.navigate(Routes.SPLASH_LOADING_PUBLISH_DISH_SCREEN,
          navigationType: NavigationType.pushReplace);
    }
  }
}
