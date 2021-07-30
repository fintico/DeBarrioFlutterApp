import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/models/auth.dart';
import 'package:debarrioapp/services/register_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:debarrioapp/widgets/verify/verify_sms_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class RegistrationSplash extends StatefulWidget {
  RegistrationSplash({Key key}) : super(key: key);

  @override
  _RegistrationSplashState createState() => _RegistrationSplashState();
}

class _RegistrationSplashState extends State<RegistrationSplash> {
  final prefs = new UserPreferences();

  TextStyle title = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_L,
    DBStyles.FONT_HEIGHT_L,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );
  var isActive = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    register();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: screenHeight(context),
          decoration: BoxDecoration(color: DBColors.BLACK),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight(context, dividedBy: 2.5)),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  child: SvgPicture.asset(
                    'assets/icons/loading.svg',
                    height: 124,
                    width: 224,
                    color: DBColors.WHITE,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Un momento...',
                  style: title,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future register() async {
    Response<dynamic> res = await Provider.of<RegisterService>(context)
        .postUserRegister(userAppData.signCode, userAppData.phoneNumber);
    //print(res.bodyString);

    Auth auth = Auth.fromRawJson(res.bodyString);

    await Provider.of<SellerService>(context, listen: false)
        .postSeller(auth.data.id);

    inspect(auth);
    prefs.username = auth.data.username;
    prefs.userId = auth.data.id;
    Routes.sailor.navigate(
      Routes.VERIFY_SMS,
      args:
          VerifySMSPageArgs(error: false, verifyType: 'REGISTER', errorMsg: ''),
      navigationType: NavigationType.pushReplace,
      removeUntilPredicate: (route) => true,
      //args:
    );
  }
}
