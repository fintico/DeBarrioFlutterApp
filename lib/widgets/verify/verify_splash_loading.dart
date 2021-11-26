import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/services/register_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'verify_sms_args.dart';
import 'verify_sms_page.dart';

class VerificationSMSLoading extends StatefulWidget {
  VerificationSMSLoading({Key? key}) : super(key: key);

  @override
  _VerificationSMSLoadingState createState() => _VerificationSMSLoadingState();
}

class _VerificationSMSLoadingState extends State<VerificationSMSLoading> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: verificationLoadingSplash(),
      ),
    );
  }

  FutureBuilder<Response> _buildBodyLoading(context) {
    print(userAppData.verificationCode);
    print(userAppData.phoneNumber);
    return FutureBuilder<Response>(
        future: Provider.of<RegisterService>(context).postVerifyCode(
            userAppData.verificationCode!, userAppData.phoneNumber!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              userAppData.verificationCode = '';
              print('error data');
              return VerifySMSPage(
                args: VerifySMSPageArgs(
                  verifyType: 'REGISTER',
                  error: true,
                  errorMsg: snapshot.error.toString(),
                ),
              );
            } else {
              print('estoy listo');
              /* Map<String, dynamic> jsonMap =
                  json.decode(snapshot.data.bodyString);
              userAppData.accessToken = jsonMap["data"]["access"];
              userAppData.refreshToken = jsonMap["data"]["refresh"]; */
              /* var successSplashBuilder = FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 3), () {
                    _navigateLocationRegistration();
                  }),
                  builder: (context, snapshot) {
                    return verificationSuccessSplash();
                  }); */
              return verificationSuccess();
            }
          } else {
            return verificationLoadingSplash();
          }
        });
  }

  verificationSuccess() async {
    verificationSuccessSplash();
    await Future.delayed(const Duration(seconds: 3));
    _navigateLocationRegistration();
  }

  void _navigateLocationRegistration() {
    Routes.sailor.navigate(
      Routes.REGISTRATION_LOCATION,
      navigationType: NavigationType.pushReplace,
    );
  }

  Widget verificationSuccessSplash() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Color(0xd6333333)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.385),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                child: SvgPicture.asset(
                  'assets/icons/loading.svg',
                  height: 124,
                  width: 224,
                  color: Color(0xffffffff),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text("Estamos verificando la información…",
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  Widget verificationLoadingSplash() {
    submitVericationCode();
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: const Color(0xd6333333)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.385),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                child: SvgPicture.asset(
                  'assets/icons/check_r.svg',
                  height: 124,
                  width: 224,
                  color: Color(0xffffffff),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text("¡Listo, ya estás registrado!",
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  submitVericationCode() async {
    try {
      await Provider.of<RegisterService>(context).postVerifyCode(
        userAppData.verificationCode!,
        userAppData.phoneNumber!,
      );
      Future.delayed(const Duration(seconds: 1));
      verificationSuccess();
    } catch (e) {
      print(e);
    }
  }
}
