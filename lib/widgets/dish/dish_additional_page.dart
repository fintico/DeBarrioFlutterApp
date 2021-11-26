import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/models/additionalDish.dart';
import 'package:debarrioapp/models/additionalModel.dart';
import 'package:debarrioapp/models/dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_five.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../utilsFunctions.dart';
import 'dish_style.dart';

class DishAdditional extends StatefulWidget {
  DishAdditional({Key? key}) : super(key: key);

  @override
  _DishAdditionalState createState() => _DishAdditionalState();
}

class _DishAdditionalState extends State<DishAdditional> {
  TextEditingController _textPrice = TextEditingController();
  bool? isActive;
  String? price;

  @override
  void initState() {
    super.initState();
    isActive = false;
    print(isActive);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionFive(
        leftIconAction: () => Navigator.pop(context),
        headerTitle: 'Agregar adicional',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _additionalDescription(),
                _additionalPrice(),
                _checkAdditionalFree(),
                _saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _additionalDescription() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => additionalDish.additionalDescription = value,
        style: labelInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Descripción',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Descripción',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
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

  Widget _additionalPrice() {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 32.0),
      child: TextField(
        onChanged: (value) => price = value,
        controller: _textPrice,
        style: labelInput,
        //readOnly: isActive,
        enabled: !isActive!,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: 'Precio',
          hintStyle: TextStyle(color: DBColors.GRAY_2),
          labelText: 'Precio',
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          fillColor: DBColors.GREEN,
          prefixText: "S/",
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

  Widget _checkAdditionalFree() {
    return Container(
      padding: const EdgeInsets.only(left: 13.0, top: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: isActive,
            //checkColor: DBColors.GREEN, // color of tick Mark
            //activeColor: DBColors.GRAY_11,
            onChanged: (value) {
              setState(() {
                isActive = value;
                additionalDish.isFree = isActive;
                _textPrice.text = '0.0';
                price = '0.0';
                additionalDish.price = 0.0;
              });
            },
          ),
          Text(
            'El adicional es gratis.',
            style: checkAdditionalStyle,
          )
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      height: screenHeight(context, dividedBy: 1.647),
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 24.0),
      alignment: Alignment.bottomCenter,
      child: GenericButtonOrange(
        text: 'GUARDAR',
        disable: false,
        action: () => _validatedData(),
      ),
    );
  }

  _validatedData() {
    if (!cZeroStr(additionalDish.additionalDescription)) {
      print('Please select a additional description');
      inspect(additionalDish);
      return;
    } else if (!cZeroStr(price)) {
      print('Please select a price');
      inspect(additionalDish);
    } else {
      additionalDish.price = double.parse(price!);
      if (additionalDish.price != 0.0) {
        additionalDish.isFree = false;
      }
      print('ready');
      inspect(additionalDish);
      setAdditionalDish();
    }
  }

  Future setAdditionalDish() async {
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false)
              .postAdditionalDish(
        additionalDish.additionalDescription!,
        additionalDish.price!,
        additionalDish.isFree!,
      );
      print(res.bodyString);
      Map<String, dynamic> jsonMap = json.decode(res.bodyString);
      dish.dishAdditional = jsonMap["id"];
      /* if (res.statusCode == 201) {
        //print(res.body);
        //inspect(res.body);
        final jsonBody = json.decode(res.bodyString).cast<String, dynamic>();
        Map<String, dynamic> myMap = new Map<String, dynamic>.from(jsonBody);
        print(myMap);
        print(myMap["id"]);
        dish.dishAdditional = myMap["id"];
        //print(myMap["id"]);

        /* return jsonBody
            .map<AdditionalModel>((data) => AdditionalModel.fromJson(data))
            .toList(); */
        //inspect(AdditionalModel);
      } else {
        print('nel');
      } */
      //print('DISH');
      //inspect(AdditionalModel());
      /*var add = new AdditionalDish();
      additionalDish.price = add.price;
      print(additionalDish.price); */
      Routes.sailor.navigate(
        Routes.DISH_PUBLISH_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
