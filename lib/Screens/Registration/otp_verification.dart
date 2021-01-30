import 'dart:async';
import 'dart:ffi';

import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Screens/Registration/map_loaction_set.dart';
import 'package:da_brello_ui/Screens/map_screen.dart';
import 'package:da_brello_ui/Services/FirebaseAuthService.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Otp_Verification extends StatefulWidget {
  @override
  _Otp_VerificationState createState() => _Otp_VerificationState();
}

// ignore: camel_case_types
class _Otp_VerificationState extends State<Otp_Verification> {
  int otp;
  bool checkValue = false;
  User user;
  AuthService authService = AuthService();
  bool loading=false;
  bool isTimeout=false;
  ///Database service
  DatabaseService database = DatabaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authService.verifyPhone(user.phoneNumber, smsUIUpdate, updateUser,phoneNumberNotOkay: phoneNumberNotOkay);
    });
    // phoneNumberNotOkay();
  }



  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    TextStyle headingtextStyle = TextStyle(
        color: HexColor('4C6072'),
        fontSize: 35.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans');

    TextStyle subTextStyle = TextStyle(
        color: HexColor('333333'),
        fontSize: 16.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontFamily: 'OpenSans');
    final appBar = PreferredSize(
      child: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
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
          )),
      preferredSize: Size.fromHeight(50),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        appBar: appBar,
        body: LoadingOverlay(
          color: Colors.black,
          opacity: .7,
          isLoading: loading,
          progressIndicator: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top),
              width: (MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Container(
                    child: Text("Verificion", style: headingtextStyle),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      "Ingresa el codlgo de veriticacldn SMS para",
                      style: subTextStyle,
                    ),
                  ),
                  Container(
                    child: Text("validar tu numero de celular",
                        style: subTextStyle),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 45,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        keyboardType: TextInputType.number,
                        onCompleted: onOtpCompleted),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  checkValue == false
                      ? Container(
                          child: Text("Ingressa el codigo"),
                        )
                      : GestureDetector(
                    onTap: (){
                      if(!isTimeout){
                        Fluttertoast.showToast(
                            msg: "Please wait for 45 seconds",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      else{
                        authService.verifyPhone(user.phoneNumber, smsUIUpdate, updateUser,phoneNumberNotOkay: phoneNumberNotOkay);

                      }
                    },
                        child: Container(
                            child: Text(
                              "Codigo vence en: 45 seg\n    Enviar nuevo codigo",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void gotoHomeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => MapScreen()),(Route<dynamic> route)=>false);

  }

  void onOtpCompleted(String value) {
    checkValue = true;
    authService.signInWithPhoneNumber(null, value, updateUser).then((val){
if(!val)
      Fluttertoast.showToast(
          msg: "The otp is not correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  updateUser(String userId) {
    user.id = userId;
    getUserDataFromDatabase();
  }

  smsUIUpdate(bool showEmpty) {
    isTimeout=showEmpty;
  }
  void setLoading(bool value){
    setState(() {
      loading=value;
    });
  }

  void getUserDataFromDatabase() {
    StreamSubscription userSubscription;
    userSubscription = database.getOtherUserData(user.id).listen((event) {
      if (event != null) {
        if (event.address != null && event.address.length>0) {
          user.fromUser(event);
          gotoHomeScreen();
        } else {
          gotoSelectLocation();

        }
      } else {
        gotoSelectLocation();
      }
      userSubscription.cancel();
    });
  }

  void gotoSelectLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationSetter(fromUserProfile: false,),
      ),
    );
  }

}

void phoneNumberNotOkay(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
