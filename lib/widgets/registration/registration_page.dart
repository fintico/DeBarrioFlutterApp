import 'package:flutter/material.dart';
import 'package:debarrioapp/Screens/Registration/OnBoardingScreen.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/registration/registration_args.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

class RegistrationPage extends StatefulWidget {
  final RegistrationArgs args;
  RegistrationPage({Key key, this.args}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextStyle titleStyle = DBStyles.getStyle(
    DBStyles.GRAY_1,
    DBStyles.FONT_SYZE_H2,
    DBStyles.FONT_HEIGHT_H2,
    0,
    DBStyles.FONT_WEIGHT_BOLD,
  );

  TextStyle subtextStyle = DBStyles.getStyle(
    DBStyles.BLACK,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle richSubtextStyle = DBStyles.getStyle(
    DBStyles.BLACK,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_SEMI_BOLD,
  );

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionOne(
        leftIconAction: () => gotoIntroScreen(),
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          color: Colors.blue,
          child: Column(
            children: [
              SizedBox(
                height: screenHeightwithOutToolbar(context, dividedBy: 6.0),
              ),
              titleDescription(),
              SizedBox(
                height: screenHeightwithOutToolbar(context, dividedBy: 40.0),
              ),
              subTitleDescription(),
              SizedBox(
                height: screenHeightwithOutToolbar(context, dividedBy: 30.0),
              ),
              inputRegistration(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      color: Colors.black,
      child: Text(
        '¡Regístrate \n con tu celular!',
        style: titleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget subTitleDescription() {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Así de fácil, ', style: subtextStyle),
            TextSpan(text: 'solo con tu número ', style: richSubtextStyle),
            TextSpan(text: 'accederás a\n', style: subtextStyle),
            TextSpan(
                text: 'una variedad de platillos caseros cerca de ti.',
                style: subtextStyle),
          ],
        ),
      ),
    );
  }

  void gotoIntroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => IntroScreen(),
      ),
    );
  }

  Widget inputRegistration() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        //onChanged: setInputOnChange,
        //validator: validateChange,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixText: '+',
          border: OutlineInputBorder(),
          hintText: "ingresa tu número de celular",
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
