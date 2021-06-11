import 'dart:developer';
import 'dart:io';

import 'package:debarrioapp/ServicesFire/FirebaseStorageService.dart';
import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/dish_category.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:debarrioapp/widgets/components/icons/calendar.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/radio_button.dart';
import 'package:debarrioapp/widgets/dish/dish_location_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
//import 'package:debarrioapp/models/dish.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:path/path.dart' as path;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sailor/sailor.dart';

import '../../../utilProperties.dart';
import '../../../utilsFunctions.dart';
import 'publish_style.dart';

// ignore: must_be_immutable
class RepublishPage extends StatefulWidget {
  final DishModel dishModel;
  final Address address;
  RepublishPage({Key key, this.dishModel, this.address}) : super(key: key);

  @override
  _RepublishPageState createState() => _RepublishPageState();
}

class _RepublishPageState extends State<RepublishPage> {
  StorageService storage = StorageService();

  DishModel dish = DishModel();

  DishCategory dishCategory = DishCategory();

  final picker = ImagePicker();

  String dishName;

  String categoryName;

  String stock;

  String priceDelivery;

  String pricePickup;

  String saleDate;

  String saleDateTo;

  String fromTime;

  String fromTimeTo;

  String toTime;

  String toTimeTo;

  int fromTimeIndex;

  int toTimeIndex;

  File _imageFile;

  String urlImage;

  DateTime deliveryDate;

  DateTime dishFromTime;

  DateTime dishToTime;

  String address;

  @override
  void initState() {
    // TODO: implement initState
    inspect(widget.address);
    inspect(widget.dishModel);
    if (widget.address == null) {
      print('aea');
    } else {
      print('ae2');
    }
    urlImage = widget.dishModel.image;
    saleDate = dateTimeDetail(widget.dishModel);
    categoryName = widget.dishModel.dishCategory.dishCategoryDescription;
    fromTime = timeFromDetail(widget.dishModel);
    toTime = timeToDetail(widget.dishModel);
    address = widget.address == null
        ? widget.dishModel.address.address
        : widget.address.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        _salesAddress(),
                      ],
                    ),
                  ),
                  Container(
                    height: widget.dishModel.additional != null
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
      child: cZeroStr(urlImage)
          ? Container(
              padding: const EdgeInsets.all(28.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(urlImage),
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
        onChanged: (value) => dishName = value,
        //onTap: () => validator(),
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: widget.dishModel.dishName != null
              ? widget.dishModel.dishName
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Nombre del plato',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: cZeroStr(widget.dishModel.dishName)
              ? FloatingLabelBehavior.always
              : null,
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
          hintText: categoryName,
          hintStyle: TextStyle(
            color:
                cZeroStr(widget.dishModel.dishCategory.dishCategoryDescription)
                    ? DBColors.BLACK
                    : DBColors.GRAY_2,
          ),
          labelText: 'Categoría',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(widget.dishModel.dishCategory.dishCategoryDescription)
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
        onChanged: (value) => stock = value,
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: widget.dishModel.stock != null
              ? widget.dishModel.stock.toString()
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Stock de porciones',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: widget.dishModel.stock != null
              ? FloatingLabelBehavior.always
              : null,
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
          _selectDate();
        },
        readOnly: true,
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: saleDate,
          hintStyle: TextStyle(
            color: cZeroStr(widget.dishModel.deliveryDate)
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Fecha de entrega',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: cZeroStr(widget.dishModel.deliveryDate)
              ? FloatingLabelBehavior.always
              : null,
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
          hintText: fromTime,
          hintStyle: TextStyle(
            color: cZeroStr(widget.dishModel.deliveryTimeFrom)
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Desde',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: cZeroStr(widget.dishModel.deliveryTimeFrom)
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
            color: cZeroStr(widget.dishModel.deliveryTimeTo)
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Hasta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: cZeroStr(widget.dishModel.deliveryTimeTo)
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

  Widget _priceByDelivery() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => priceDelivery = value,
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: widget.dishModel.priceDelivery != null
              ? "S/ ${widget.dishModel.priceDelivery.toString()}"
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Precio con delivery (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: widget.dishModel.priceDelivery != null
              ? FloatingLabelBehavior.always
              : null,
          fillColor: DBColors.GREEN,
          prefixText: widget.dishModel.priceDelivery != null ? "" : "S/",
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
        onChanged: (value) => pricePickup = value,
        style: labelInput,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: widget.dishModel.pricePickup != null
              ? "S/ ${widget.dishModel.pricePickup.toString()}"
              : '',
          hintStyle: TextStyle(color: DBColors.BLACK),
          labelText: 'Precio con recojo (por porción)',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior: widget.dishModel.pricePickup != null
              ? FloatingLabelBehavior.always
              : null,
          fillColor: DBColors.GREEN,
          prefixText: widget.dishModel.pricePickup != null ? "" : "S/",
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

  Widget _salesAddress() {
    return Container(
      padding: const EdgeInsets.only(
          left: 28.0, right: 28.0, top: 32.0, bottom: 32.0),
      child: TextField(
        readOnly: true,
        onTap: () {
          Routes.sailor.navigate(Routes.LOCATION_CHANGE_PAGE,
              navigationType: NavigationType.push,
              params: {'dishModel': widget.dishModel});
        },
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: address,
          hintStyle: TextStyle(
            color: cZeroStr(
              address,
            )
                ? DBColors.BLACK
                : DBColors.GRAY_2,
          ),
          labelText: 'Dirección para la venta',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(address) ? FloatingLabelBehavior.always : null,
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
      height: widget.dishModel.additional != null
          //? screenHeight(context, dividedBy: 2.225)
          ? screenHeight(context, dividedBy: 2.18)
          : screenHeight(context, dividedBy: 4.35),
      child: Column(
        children: [
          Container(
            //height: 70.0,
            color: DBColors.GRAY_8,
            child: Column(
              children: [
                widget.dishModel.additional != null
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
                                          widget.dishModel.additional != null
                                              ? widget.dishModel.additional
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
                                          widget.dishModel.additional != null
                                              ? 'S/ ${widget.dishModel.additional.price.toString()}'
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
                left: 28.0, right: 28.0, top: 28, bottom: 24.0),
            width: screenWidth(context),
            //height: 92.0,
            color: DBColors.WHITE,
            child: GenericButtonOrange(
              text: 'PUBLICAR VENTA',
              disable: false,
              action: () => setPostedDish(),
            ),
            /* child: ElevatedButton(
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
            ), */
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
                              categoryName = categoryList;
                              dishCategory.id = index + 1;
                              dishCategory.dishCategoryDescription =
                                  categoryList;
                            });
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
                            });
                            _selectDateFrom();
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
                            });
                            _selectDateTo();
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

  void _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2030),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      final formatter = new DateFormat('dd/MM/yyyy');
      final formatterTo = new DateFormat('yyyy-MM-dd');

      setState(() {
        saleDate = formatter.format(picked);
        saleDateTo = formatterTo.format(picked);
        deliveryDate = picked;
      });
    }
  }

  void _selectDateFrom() {
    dishFromTime = DateTime(
      deliveryDate.year,
      deliveryDate.month,
      deliveryDate.day,
      fromTimeIndex,
    );
    final timeFormatter = new DateFormat('H:mm');
    fromTimeTo = timeFormatter.format(dishFromTime);
  }

  void _selectDateTo() {
    dishToTime = DateTime(
      deliveryDate.year,
      deliveryDate.month,
      deliveryDate.day,
      toTimeIndex,
    );
    final timeFormatter = new DateFormat('H:mm');
    toTimeTo = timeFormatter.format(dishToTime);
  }

  Future pickDishImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      uploadImage();
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
          dish.image = value;
        });
      },
    );
  }

  Future setPostedDish() async {
    dish.dishName = cZeroStr(dishName) ? dishName : widget.dishModel.dishName;
    dish.dishCategory = cZeroStr(dishCategory.dishCategoryDescription)
        ? dishCategory
        : widget.dishModel.dishCategory;
    dish.stock = cZeroStr(stock) ? int.parse(stock) : widget.dishModel.stock;
    dish.deliveryDate =
        cZeroStr(saleDateTo) ? saleDateTo : widget.dishModel.deliveryDate;
    dish.deliveryTimeFrom =
        cZeroStr(fromTimeTo) ? fromTimeTo : widget.dishModel.deliveryTimeFrom;
    dish.deliveryTimeTo =
        cZeroStr(toTimeTo) ? toTimeTo : widget.dishModel.deliveryTimeTo;
    dish.priceDelivery = cZeroStr(priceDelivery)
        ? double.parse(priceDelivery)
        : widget.dishModel.priceDelivery;
    dish.pricePickup = cZeroStr(pricePickup)
        ? double.parse(pricePickup)
        : widget.dishModel.pricePickup;
    dish.additional = widget.dishModel.additional;
    dish.address = cZeroStr(widget.address.address)
        ? widget.address
        : widget.dishModel.address;
    dish.image = widget.dishModel.image;
    dish.seller = widget.dishModel.seller;
    dish.id = widget.dishModel.id;
    dish.isActive = true;
    dish.isDeleted = false;

    inspect(dish);
    if (dish.id != null) {
      Routes.sailor.navigate(Routes.SPLASH_LOADING_REPUBLISH_SCREEN,
          navigationType: NavigationType.pushReplace,
          params: {'dishModel': dish});
    } else {
      print('falta datos');
    }

    /* if (!cZeroStr(dish.dishName)) {
      print('Please select a dish name');
      inspect(dish);
      return;
    } else {
      print('ready');
      inspect(dish);
      /* Routes.sailor.navigate(Routes.SPLASH_LOADING_PUBLISH_DISH_SCREEN,
          navigationType: NavigationType.pushReplace); */
    } */
  }
}
