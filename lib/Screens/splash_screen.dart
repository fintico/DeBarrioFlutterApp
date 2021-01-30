import 'dart:async';

import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Services/FirebaseAuthService.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Registration/OnBoardingScreen.dart';
import 'Registration/map_loaction_set.dart';
import 'Registration/phonenumber.dart';
import 'map_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Function goToTab;
  AuthService authService= AuthService();
  User user;
  DatabaseService database = DatabaseService();
  // bool loading=true;
  BuildContext currentContext;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateView();
  }

  @override
  Widget build(BuildContext context) {
    currentContext=context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              "assets/images/Logo.png",
            ),
          ),
        ),
      ),
    );
  }


  Future<void> updateView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString("First_Time") ?? '';
    if (counter !='') {
      String userId = await authService.currentUserIdFromAuth();
      if (userId != '') {
        getUserDataFromDatabase(userId);
      }
      else{
        onDonePress();
      }
    }
    else{
      await prefs.setString("First_Time", 'No');
      setState(() {
        gotoIntroScreen();

      });
      return;

    }

  }
  void gotoHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MapScreen(),
      ),
    );
  }
  void gotoSelectLocation() {
    // setUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LocationSetter(fromUserProfile: false),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PhoneNumScreen(),
      ),
    );
  }

  void getUserDataFromDatabase(String userId) {
    StreamSubscription userSubscription;
    userSubscription = database.getOtherUserData(userId).listen((event) {
      if (event != null) {
        user=Provider.of<User>(currentContext,listen: false);
        user.fromUser(event);
        if (event.address != null && event.address.length>0) {
          gotoHomeScreen();
        } else {
          gotoSelectLocation();
        }
      }
      else{
        onDonePress();
      }
      userSubscription.cancel();
    });
  }
  void onSkipPress() {
    this.goToTab(1);
  }

  void gotoIntroScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => IntroScreen(),
      ),
    );
  }




}
