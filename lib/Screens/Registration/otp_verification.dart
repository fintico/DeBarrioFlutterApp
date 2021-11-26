import 'dart:async';

import 'package:debarrioapp/ServicesFire/FirebaseAuthService.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/models/user.dart';
import 'package:debarrioapp/providers/register_provider.dart';
import 'package:debarrioapp/providers/user_provider.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/widgets/location/location_page.dart';
import 'package:debarrioapp/widgets/registration/registration_splash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Otp_Verification extends StatefulWidget {
  final String? phoneNumber;

  const Otp_Verification({Key? key, this.phoneNumber}) : super(key: key);
  @override
  _Otp_VerificationState createState() => _Otp_VerificationState();
}

// ignore: camel_case_types
class _Otp_VerificationState extends State<Otp_Verification> {
  int? otp;
  bool checkValue = false;
  User? user;
  AuthService authService = AuthService();
  bool loading = false;
  bool isTimeout = false;

  TextStyle timeOutStyle = DBStyle.getStyle(
    DBStyle.GREEN,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );
  TextStyle newCodeStyle = DBStyle.getStyle(
    DBStyle.GREEN,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );

  Timer? _timer;
  int _start = 45;

  final register = registerProvider<RegisterProvider>();

  ///Database service
  //DatabaseService database = DatabaseService();

  @override
  void initState() {
    super.initState();
    print(widget.phoneNumber);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      authService.verifyPhone(widget.phoneNumber!, smsUIUpdate, updateUser,
          phoneNumberNotOkay: phoneNumberNotOkay);
    });
    // phoneNumberNotOkay();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    TextStyle headingtextStyle = TextStyle(
        color: DBColors.GRAY_17,
        fontSize: 35.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontFamily: 'OpenSans');

    TextStyle subTextStyle = TextStyle(
        color: DBColors.BLACK,
        fontSize: 16.0,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontFamily: 'OpenSans');
    final appBar = PreferredSize(
      child: Container(
        //color: Colors.black,
        child:
            /* Row(
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
          ) */
            AppBarOptionOne(
          leftIconAction: () => Navigator.pop(context),
        ),
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.WHITE,
        appBar: appBar,
        body: LoadingOverlay(
          color: Colors.black,
          opacity: .7,
          isLoading: loading,
          progressIndicator: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [Colors.white],
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
                    child: Text("Verificación", style: headingtextStyle),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      "Ingresa el código de veriticación SMS para",
                      style: subTextStyle,
                    ),
                  ),
                  Container(
                    child: Text("validar tu número de celular",
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
                      onCompleted: onOtpCompleted,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  checkValue == false
                      ? Container(
                          child: Text("Ingresa el código",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontFamily: 'OpenSans')),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (!isTimeout) {
                              Fluttertoast.showToast(
                                  msg: "Please wait for 45 seconds",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              authService.verifyPhone(userProvider.phoneNumber!,
                                  smsUIUpdate, updateUser,
                                  phoneNumberNotOkay: phoneNumberNotOkay);
                            }
                          },
                          child: Container(
                            /* child: Text(
                              "Código vence en: 45 seg\n    Enviar nuevo codigo",
                              style: TextStyle(color: Colors.green),
                            ), */
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Código vence en: $_start seg\n',
                                    style: timeOutStyle,
                                  ),
                                  TextSpan(
                                    text: 'Enviar nuevo código',
                                    style: newCodeStyle,
                                  )
                                ])),
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  /* void gotoHomeScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MapScreen()),
        (Route<dynamic> route) => false);
  } */

  void onOtpCompleted(String value) {
    startTimer();
    print(value);
    checkValue = true;
    register.code = value;
    authService.signInWithPhoneNumber(null, value, updateUser).then((val) {
      print('otp completed $val');
      if (!val)
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

  updateUser(String uid) {
    print(uid);
    register.uid = uid;
    //user.uid = userId;

    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UiScreen(
          uid: userId,
        ),
      ),
    ); */
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegistrationSplash()),
    );

    //getUserDataFromDatabase();
  }

  smsUIUpdate(bool showEmpty) {
    isTimeout = showEmpty;
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  /* void getUserDataFromDatabase() {
    StreamSubscription userSubscription;
    userSubscription = database.getOtherUserData(user.id).listen((event) {
      if (event != null) {
        if (event.address != null && event.address.length > 0) {
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
  } */

  /* void gotoSelectLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationSetter(
          fromUserProfile: false,
        ),
      ),
    );
  } */
}

void phoneNumberNotOkay(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
