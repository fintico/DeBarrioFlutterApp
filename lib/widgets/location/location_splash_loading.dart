import 'package:chopper/chopper.dart';
import 'package:debarrioapp/Services/location_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class LocationSplash extends StatefulWidget {
  LocationSplash({Key key}) : super(key: key);

  @override
  _LocationSplashState createState() => _LocationSplashState();
}

class _LocationSplashState extends State<LocationSplash> {
  TextStyle title = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_L,
    DBStyles.FONT_HEIGHT_L,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setLocation();
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: screenHeight(context),
          decoration: BoxDecoration(color: DBColors.BLACK),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  'Estamos confirmando tu \n ubicación...',
                  style: title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future setLocation() async {
    try {
      Response<dynamic> res = await Provider.of<LocationService>(context)
          .postUserLocation(userAppData.address, userAppData.addressDescription,
              true, userAppData.longitude, userAppData.latitude);
      print(res.bodyString);
      Routes.sailor.navigate(
        Routes.HOME_SCREEN,
        navigationType: NavigationType.pushReplace,
        removeUntilPredicate: (route) => true,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
