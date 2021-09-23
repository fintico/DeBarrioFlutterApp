import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/Screens/calendar_splash.dart';
import 'package:debarrioapp/Screens/nav_drawer.dart';
import 'package:debarrioapp/Screens/paysplash.dart';
import 'package:debarrioapp/models/customer_address.dart';
import 'package:debarrioapp/services/customer_service.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/services/seller_address_service.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_three.dart';
import 'package:debarrioapp/widgets/components/icons/place.dart';
import 'package:debarrioapp/widgets/components/transitions/slide_right_transition.dart';
import 'package:debarrioapp/widgets/home/location/location_home_page.dart';
import 'package:debarrioapp/widgets/shopping_cart/shopping_cart_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../utilsFunctions.dart';
import 'home_bottom_modal.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController myMapController;
  final prefs = new UserPreferences();
  static const LatLng _mainLocation =
      const LatLng(-12.03264748063415, -77.0454660731605);
  CameraPosition _initialLocation;
  //double latitude = userAppData.latitude;
  double latitude;
  //double longitude = userAppData.longitude;
  double longitude;
  BitmapDescriptor customStartMark;
  Set<Marker> markers = {};
  Set<Marker> markersList = {};
  String _mapStyle;
  String address = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _setIconStartMarker();
      _fetchData();
    });

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    //_setIconStartMarker();

    latitude = prefs.latitude;
    longitude = prefs.longitude;
    address = prefs.address;

    _initialLocation =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16.0);
    //print('Home Page');
    //print(latitude);
    //print(longitude);

    //_onAddMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    //print(address);
    final appBar = PreferredSize(
      child: AppBarOptionThree(
        leftIconAction: () {
          Routes.sailor.navigate(
            Routes.MENU_SCREEN,
            navigationType: NavigationType.push,
            transitions: [
              SailorTransition.fade_in,
              SailorTransition.slide_from_left
            ],
          );
        },
        rightIconAction: () {
          if (purchaseBloc.orderDetails.length == 0) {
            Routes.sailor.navigate(
              Routes.SPLASH_EMPTY_CART_SCREEN,
              navigationType: NavigationType.push,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ShoppingCartHome(),
              ),
            );
          }
        },
        secondaryIconAction: () {
          Navigator.push(
              //context, MaterialPageRoute(builder: (_) => CalendarTimeline()));
              context,
              MaterialPageRoute(builder: (_) => CalendarSplash()));
        },
        subTitleIconAction: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomeLocation()));
        },
        subTitle: address,
        //subTitle: '-',
      ),
      preferredSize: Size.fromHeight(104.0),
    );
    //_setStartMarker(-12.0891486, -77.0724173);
    //_setStartMarker(-12.0891486, -77.0724173);
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
    //print(lat);
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
            //CameraPosition(target: _mainLocation, zoom: 10.0),
            _initialLocation,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: true,
        mapType: MapType.normal,
        markers: markersList,
        trafficEnabled: false,
        indoorViewEnabled: false,

        //markers: _markers,
        //onTap: setCurrentMarkerFromCoordinates,
        onMapCreated: (controller) {
          setState(() {
            myMapController = controller;
          });
        },
        //onMapCreated: _onMapCreated,
      ),
    );
  }

  Widget _placeFLoatingActionButton() {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, bottom: 270.0),
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

  _setStartMarker(double lat, double lng) {
    //setState(() {
    Marker startMarker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        lat,
        lng,
      ),
      icon: customStartMark,
    );
    markers.add(startMarker);
    //_initialLocation = CameraPosition(target: LatLng(lat, lng), zoom: 15.0);

    //});
  }

  _setIconStartMarker() async {
    await getBytesFromAsset('assets/icons/placeholder.png', 64)
        .then((value) => customStartMark = BitmapDescriptor.fromBytes(value));
  }

  _onAddMarkers() {
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    if (cZeroStr(homeBloc.seller)) {
      for (var i = 0; i < homeBloc.seller.length; i++) {
        Marker marker = Marker(
          markerId: MarkerId((homeBloc.seller[i].userId).toString()),
          position: LatLng(
            homeBloc.seller[i].sellers[0].address.latitude,
            homeBloc.seller[i].sellers[0].address.longitude,
          ),
          icon: customStartMark,
        );
        markersList.add(marker);
      }
    } else {
      print('no hay data');
    }
  }

  _onMapCreated(GoogleMapController controller) {
    if (mounted)
      setState(() {
        myMapController = controller;
        controller.setMapStyle(_mapStyle);
      });
  }

  _fetchData() async {
    await _getUserData();
    await _getRestaurants();
    await _getPosts();
  }

  Future _getRestaurants() async {
    try {
      final homeBloc = Provider.of<HomeBloc>(context, listen: false);
      //print(homeBloc.deliveryDate);
      if (homeBloc.deliveryDate == null) {
        /* Response<dynamic> res =
            await Provider.of<SellerService>(context, listen: false)
                .getDishesBySeller();
        homeBloc.sellers = (json.decode(res.bodyString) as List)
            .map((e) => SellerDish.fromJson(e))
            .toList(); */
        Response<dynamic> res =
            await Provider.of<SellerService>(context, listen: false)
                .getDishesBySeller();
        List<SellerDetail> seller = (json.decode(res.bodyString) as List)
            .map((e) => SellerDetail.fromJson(e))
            .toList();
        homeBloc.onSetSellerDetail(seller);
      }
      //inspect(homeBloc.seller);
      _onAddMarkers();
      //print(sellers.length);

    } catch (e) {
      print(e.toString());
    }
  }

  Future _getUserData() async {
    try {
      final homeBloc = Provider.of<HomeBloc>(context, listen: false);

      Response<dynamic> res =
          await Provider.of<SellerAddressService>(context, listen: false)
              .getSellerDetail(prefs.userId);
      SellerAddress sellerAddress = SellerAddress.fromRawJson(res.bodyString);
      homeBloc.onSetSellerAddress(sellerAddress);

      Response<dynamic> resCustomer =
          await Provider.of<CustomerService>(context, listen: false)
              .getCustomerDetail(prefs.userId);
      CustomerAddress customerAddress =
          CustomerAddress.fromRawJson(resCustomer.bodyString);
      homeBloc.onSetCustomerAddress(customerAddress);
      print(homeBloc.customerAddress.id);
    } catch (e) {
      print(e.toString());
    }
  }

  Future _getPosts() async {
    try {
      final dishProvider = Provider.of<DishProvider>(context, listen: false);

      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false).getDishList();

      List<DishModel> dishList = (json.decode(res.bodyString) as List)
          .map((e) => DishModel.fromJson(e))
          .toList();
      dishProvider.setList(dishList);
    } catch (e) {
      print(e.toString());
    }
  }
}
