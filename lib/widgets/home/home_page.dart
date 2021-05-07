import 'package:debarrioapp/Screens/calendar_splash.dart';
import 'package:debarrioapp/Screens/nav_drawer.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_three.dart';
import 'package:debarrioapp/widgets/components/icons/place.dart';
import 'package:debarrioapp/widgets/components/transitions/slide_right_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import '../../utilsFunctions.dart';
import 'home_bottom_modal.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController myMapController;
  static const LatLng _mainLocation = const LatLng(-12.0630149, -77.0296179);
  double latitude = userAppData.latitude;
  double longitude = userAppData.longitude;

  @override
  void initState() {
    super.initState();
    print('Home Page');
    print(latitude);
    print(longitude);
    //moveCamera(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionThree(
        leftIconAction: () {
          Navigator.push(context, SlideRightRoute(page: NavDrawer()));
        },
        rightIconAction: () {
          /* if (cZeroStr(orderList.myOrders)) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FoodCart()));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PaySplash()));
            } */
        },
        secondaryIconAction: () {
          Navigator.push(
              //context, MaterialPageRoute(builder: (_) => CalendarTimeline()));
              context,
              MaterialPageRoute(builder: (_) => CalendarSplash()));
        },
        subTitleIconAction: () {},
        subTitle: userAppData.address,
      ),
      preferredSize: Size.fromHeight(104.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        //backgroundColor: DBC,
        body: Stack(
          children: [
            _myMap(),
            _placeFLoatingActionButton(),
            BottomModal(),
          ],
        ),
      ),
    );
  }

  void moveCamera(lat, lng) {
    print(lat);
    myMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.0,
        ),
      ),
    );
  }

  Widget _myMap() {
    return Container(
      height: screenHeight(context, dividedBy: 1),
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _mainLocation, zoom: 10.0),
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        //markers: _markers,
        //onTap: setCurrentMarkerFromCoordinates,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            myMapController = controller;
          });
        },
      ),
    );
  }

  Widget _placeFLoatingActionButton() {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, bottom: 140.0),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          moveCamera(latitude, longitude);
        },
        backgroundColor: DBColors.WHITE,
        child: PlaceIcon(
          height: 38.0,
          width: 38.0,
          color: DBColors.GRAY_2,
        ),
      ),
    );
  }
}
