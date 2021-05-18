import 'package:chopper/chopper.dart';
import 'package:debarrioapp/services/register_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'OnBoardingScreen.dart';
import 'otp_verification.dart';

class PhoneNumScreen extends StatefulWidget {
  @override
  _PhoneNumScreenState createState() => _PhoneNumScreenState();
}

class _PhoneNumScreenState extends State<PhoneNumScreen> {
  TextEditingController _phoneCheck = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user;
  bool disable = true;
  var isActive = false;
  TextStyle subtextStyle = TextStyle(
    color: HexColor('333333'),
    fontSize: 14.0,
    letterSpacing: 0.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontFamily: 'OpenSans',
  );
  TextStyle richSubtextStyle = TextStyle(
    color: HexColor('333333'),
    fontSize: 14.0,
    letterSpacing: 0.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
  );
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    TextStyle textStyle = TextStyle(
        color: HexColor('4C6072'),
        fontSize: 35.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans');

    Text term = Text(
      "Términos y Condiciones",
      style: TextStyle(
          color: Colors.green,
          decoration: TextDecoration.underline,
          fontSize: 12.0,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          fontFamily: 'OpenSans'),
    );

    TextStyle termTextStyle = TextStyle(
        color: HexColor('333333'),
        fontSize: 12.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans');
    final appBar = PreferredSize(
      child: Container(
        //color: Colors.black,
        child:
            /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
            Container(
              width: MediaQuery.of(context).size.width / 8,
            ),
          ],
        ),
       */
            AppBarOptionOne(leftIconAction: () => gotoIntroScreen()),
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        //backgroundColor: HexColor("#f2f2f2"),
        appBar: appBar,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(
                      "Al darle en '" 'Continuar' "' estoy aceptando los",
                      style: termTextStyle),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: term,
                ),
              ),
              Container(
                height: 20,
              ),
              //continueButton(),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RaisedButton(
                    elevation: 0.0,
                    color: !userAppData.registrationArgs.isReady
                        ? HexColor('E3E3E3')
                        : HexColor('E84A31'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: onSubmit,
                    child: Text(
                      "CONTINUAR",
                      style: TextStyle(
                        color: !userAppData.registrationArgs.isReady
                            ? Colors.blueGrey[700]
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top),
            width: (MediaQuery.of(context).size.width),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Container(
                    child: Text("¡Regístrate", style: textStyle),
                  ),
                  Container(
                    child: Text("con tu celular!", style: textStyle),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child:
                        /* Text("Así de fácil, solo con to número accederás a",
                        style: subtextStyle), */
                        subTitleDescription(),
                  ),
                  /* Container(
                    child: Text(
                        "una variedad de platillos caseros cerca de ti.",
                        style: subtextStyle),
                  ), */
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Container(
                      child: TextFormField(
                        onChanged: setInputOnChange,
                        validator: validateChange,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          //prefixText: '+',
                          border: OutlineInputBorder(),
                          hintText: "Ingresa tu número de celular",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ),
                  Container(height: MediaQuery.of(context).size.height * 0.16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setInputOnChange(value) {
    //_phoneCheck.text = value;

    /* disable = _phoneCheck.text.isNotEmpty
          ? false
          : (_phoneCheck.text.length > 10 ? false : true); */
    if (value.length < 9) {
      userAppData.registrationArgs.isReady = false;
      userAppData.registrationArgs.alreadyExist = false;
      userAppData.registrationArgs.errorMessage = '';
      setState(() {
        this.isActive = true;
        _phoneCheck.text = value;
      });
      print('<9');
      print(value);
      print(userAppData.registrationArgs.phoneNumber);
    }
    if (value.length == 9) {
      userAppData.registrationArgs.phoneNumber = '51' + value;
      userAppData.registrationArgs.isReady = true;
      setState(() {
        _phoneCheck.text = value;
        this.isActive = false;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      print('==9');
      print(value);
      print(userAppData.registrationArgs.phoneNumber);
    }

    /* print(_phoneCheck.text);
      print(_phoneCheck.text.length);
      print('Disable $disable'); */
  }

  void gotoIntroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => IntroScreen(),
      ),
    );
  }

  String validateChange(phoneNumber) {
    if (phoneNumber.length < 9) {
      return 'El número ingresado no es válido';
    }
    return null;
  }

  Future<dynamic> onSubmit() async {
    if (userAppData.registrationArgs.isReady) {
      userAppData.phoneNumber = userAppData.registrationArgs.phoneNumber;
      userAppData.signCode = await SmsAutoFill().getAppSignature;

      /* Response<dynamic> res =
          await Provider.of<RegisterService>(context, listen: false)
              .postUserRegister(userAppData.signCode, userAppData.phoneNomber);
      print(res.bodyString); */
      Routes.sailor.navigate(Routes.SPLASH_LOADING_REGISTRATION_SCREEN,
          navigationType: NavigationType.pushReplace);
    } else {
      print('No esta ready');
    }

    /* if (_formKey.currentState.validate()) {
      user.phoneNumber = '+' + _phoneCheck.text;
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Otp_Verification(),
        ),
      );
    } */
    return null;
  }

  Widget continueButton() {
    return GenericButtonOrange(
        text: 'CONTINUAR',
        /* disable: _phoneCheck.text.isEmpty
            ? true
            : (_phoneCheck.text.length <= 10 ? true : false), */
        disable: disable,
        action: onSubmit);
  }

  Widget subTitleDescription() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
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

  bool setButtonDisable() {
    bool disable;
    setState(() {
      disable = _phoneCheck.text.isEmpty ? true : false;
      print(disable);
      return disable;
    });
    return disable;
  }
}
