import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'otp_verification.dart';

class PhoneNumScreen extends StatefulWidget {
  @override
  _PhoneNumScreenState createState() => _PhoneNumScreenState();
}

class _PhoneNumScreenState extends State<PhoneNumScreen> {
  TextEditingController _phoneCheck = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user;
  @override
  Widget build(BuildContext context) {
    user=Provider.of<User>(context);
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
          fontSize: 15.0,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w500,
          fontFamily: 'RobotoMono'),
    );

    TextStyle subtextStyle = TextStyle(
        color: HexColor('333333'),
        fontSize: 15.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans');
    final appBar = PreferredSize(
      child: Container(
          color: Colors.black,
          child: Row(
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 8,
              ),
            ],
          )),
      preferredSize: Size.fromHeight(50),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        appBar: appBar,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text("AI darle eh Continuar estay aceptando Ios",
                      style: subtextStyle),
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
              ),SizedBox(
                width: double.infinity,
                height: 70,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RaisedButton(
                    elevation: 0.0,
                    color: _phoneCheck.text.length<=10
                        ? HexColor('E3E3E3')
                        : HexColor('E84A31'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: onSubmit,
                    child: Text(
                      "CONTINUAR",
                      style: TextStyle(
                        color: _phoneCheck.text.isEmpty
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
            height: (MediaQuery
                .of(context)
                .size
                .height -
                appBar.preferredSize.height -
                MediaQuery
                    .of(context)
                    .padding
                    .top),
            width: (MediaQuery
                .of(context)
                .size
                .width),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
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
                    child: Text("Así de fácll, solo con to número áccederás a",
                        style: subtextStyle),
                  ),
                  Container(
                    child: Text("una variedad de platIllos caseros cerca de U.",
                        style: subtextStyle),
                  ),
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
                          prefixText: '+',
                          border: OutlineInputBorder(),
                          hintText: "ingresa tu número de celular",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ),
                  Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.16),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setInputOnChange(value) {
    setState(() {
      _phoneCheck.text = value;
    });
  }

  String validateChange(phoneNumber) {
    if (phoneNumber.length <= 10) {
      return 'Please enter a Valid Number';
    }
    return null;
  }

  Future<dynamic> onSubmit() {
    if(_formKey.currentState.validate()){
      user.phoneNumber='+'+_phoneCheck.text;
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Otp_Verification(),
        ),
      );
    }
    return null;
  }
}
