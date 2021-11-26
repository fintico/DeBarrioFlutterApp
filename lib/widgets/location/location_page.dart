import 'dart:developer';

import 'package:debarrioapp/providers/location_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/service_locator.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/utils/user_preferences.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/components/icons/place.dart';
import 'package:debarrioapp/widgets/components/icons/search.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_two.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sailor/sailor.dart';

import '../../utilsFunctions.dart';
import 'location_style.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? myMapController;
  Set<Marker> _markers = new Set();
  BitmapDescriptor? customMark;
  TextEditingController _address = TextEditingController();

  static const LatLng _mainLocation = const LatLng(-12.0630149, -77.0296179);

  Position? currentPosition;
  double? lat;
  double? lng;

  String? _mapStyle;

  final location = locationProvider<LocationProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _locationAlert(context);
    });
    getBytesFromAsset('assets/icons/placeholder.png', 84)
        .then((value) => customMark = BitmapDescriptor.fromBytes(value));

    /* rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    }); */
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
        child: AppBarOptionTwo(
            leftIconAction: () {},
            //rightIconAction: () {},
            title: 'Confirma tu ubicación'),
        preferredSize: Size.fromHeight(104.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          alignment: Alignment.center,
          width: screenWidth(context),
          height: screenHeight(context),
          child: Stack(
            children: [
              _myMap(),
              _placeFLoatingActionButton(),
            ],
          ),
        ),
        bottomNavigationBar: _myBottomNav(),
      ),
    );
  }

  Future _locationAlert(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                SvgPicture.asset(
                  'assets/images/place.svg',
                  height: 68.0,
                  width: 68.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '!Cuéntanos!',
                  style: titleAlert,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'De Barrio quiere utlizar tu \n ubicación actual para mostrarte \n las mejores opciones cerca de ti.',
                  style: subTitleAlert,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.0,
                ),
                Flexible(
                  child: GenericButtonOrange(
                    text: 'ACEPTAR',
                    disable: false,
                    height: 48,
                    action: () async {
                      getLocationPermission(setPosition);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(
                  child: GenericButtonWhite(
                    text: 'CANCELAR',
                    disable: false,
                    action: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //FlutterLogo(size: 100.0),
              ],
            ),
          ),
        );
      },
    );
  }

  ///Set current location when user search for a place
  Future<void> getLocationCoOrdinatesWithAddress(String addressQuery) async {
    //setLoading(true);
    var address = await Geocoder.local.findAddressesFromQuery(addressQuery);
    var first = address.first;
    print(first);
    /* setState(() {
      _textLocation.text = first.addressLine;
    }); */
    setMarker(first);
  }

  ///Set current location when user click on a location on map
  Future<void> setCurrentMarkerFromCoordinates(LatLng argument) async {
    //setLoading(true);
    var address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(argument.latitude, argument.longitude));
    var first = address.first;
    print(first.addressLine);
    /* setState(() {
      _textLocation.text = first.addressLine;
    }); */
    setMarker(first);
  }

  void moveCamera(lat, lng) async {
    var address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lat, lng));
    var first = address.first;
    var addressTemp = first.addressLine!.split(",");
    var addressUser = '${addressTemp[0]}, ${first.locality}';
    myMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.0,
        ),
      ),
    );
    setState(() {
      _address.text = addressUser;
    });
    _createMarker(lat, lng);
    _setAddress(addressUser, lat, lng);
  }

  void setMarker(Address first) {
    _markers = Set();
    /* inAppAddress = InAppAddress(
        addressId: Uuid().v4(),
        addressLanLon:
            GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
        addressString: first.addressLine); */
    moveCamera(first.coordinates.latitude, first.coordinates.longitude);
    var addressTemp = first.addressLine!.split(",");
    var addressUser = '${addressTemp[0]}, ${first.locality}';
    setState(() {
      //_textLocation.text = addressUser;
      //setLoading(false);
      _markers.add(
        Marker(
          markerId: MarkerId('current Location'),
          position: LatLng(
            first.coordinates.latitude!,
            first.coordinates.longitude!,
          ),
          icon: customMark!,
        ),
      );
    });
  }

  _createMarker(lat, lng) {
    _markers = Set();
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(''),
          position: LatLng(lat, lng),
          icon: customMark!,
        ),
      );
    });
  }

  setPosition(Position position) async {
    currentPosition = position;
    print('CURRENT POS: $currentPosition');
    var address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    var first = address.first;
    var addressTemp = first.addressLine!.split(",");
    var addressUser = '${addressTemp[0]}, ${first.locality}';
    setState(() {
      moveCamera(position.latitude, position.longitude);
      //_textLocation.text = addressUser;
      lat = position.latitude;
      lng = position.longitude;
      _createMarker(lat, lng);
      print(lat);
      print(lng);
    });
  }

  _setAddress(String address, double lat, double lng) {
    if (address != null && address.length > 0) {
      //userAppData.address = address;
      //userAppData.latitude = lat;
      //userAppData.longitude = lng;
      //inspect(userAppData);
      location.address = address;
      location.latitude = lat;
      location.longitude = lng;
      print('estoy listo');
    } else {
      print('no estoy listo');
    }
  }

  Widget _myMap() {
    return Container(
      height: screenHeight(context, dividedBy: 2.242),
      child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _mainLocation, zoom: 10.0),
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          markers: _markers,
          onTap: setCurrentMarkerFromCoordinates,
          mapType: MapType.normal,
          onMapCreated: onMapCreatedEvent
          /* (controller) {
          setState(() {
            myMapController = controller;
            controller.setMapStyle(_mapStyle);
          });
        }, */
          ),
    );
  }

  Widget _placeFLoatingActionButton() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {
          moveCamera(lat, lng);
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

  Widget _myBottomNav() {
    return Container(
      height: screenHeight(context, dividedBy: 2.5),
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
              ),
              child: Text(
                "¿Dónde te encuentras?",
                style: subtitleStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
            ),
            width: MediaQuery.of(context).size.width,
            //height: 48.0,
            height: screenHeight(context, dividedBy: 15.8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: screenWidth(context, dividedBy: 1.165),
                child: TextFormField(
                  controller: _address,
                  readOnly: true,
                  onFieldSubmitted: (value) {
                    getLocationCoOrdinatesWithAddress(value);
                  },
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: SearchIcon(
                        height: 24.0,
                        width: 24.0,
                        color: DBColors.GRAY_2,
                      ),
                      onPressed: () => {
                        /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SearchModalSheet(
                                            setCurrentMarkerFromCoordinates:
                                                setCurrentMarkerFromCoordinates,
                                            getLocationCoOrdinatesWithAddress:
                                                getLocationCoOrdinatesWithAddress,
                                            forMap: true,
                                          )),
                                ), */
                      },
                    ),
                    border: OutlineInputBorder(),
                    hintText: "Ejemplo: ",
                    hintStyle: textHintStyle,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
              ),
              child: Text(
                "Nro.de Apartamento/Piso/Interior",
                style: subtitleStyle,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0,
            ),
            width: MediaQuery.of(context).size.width,
            height: screenHeight(context, dividedBy: 15.8),
            child: TextFormField(
              readOnly: false,
              //onChanged: (value) => userAppData.addressDescription = value,
              onChanged: (value) => location.addressDescription = value,
              //keyboardType: TextInputType.streetAddress,
              style: textFieldStyle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ejemplo: Apartamento 12",
                hintStyle: textHintStyle,
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
            height: screenHeight(context, dividedBy: 15.8),
            width: MediaQuery.of(context).size.width,
            child: GenericButtonOrange(
              action: () {
                Routes.sailor.navigate(Routes.SPLASH_LOADING_LOCATION_SCREEN,
                    navigationType: NavigationType.pushReplace);
              },
              disable: false,
              text: 'CONFIRMAR',
              height: 48.0,
            ),
          ),
        ],
      ),
    );
  }

  void onMapCreatedEvent(controller) {
    myMapController = controller;
    _loadMapStyle(myMapController!);
  }

  void _loadMapStyle(GoogleMapController googleMapController) {
    rootBundle.loadString('assets/map_style.json').then((mapStyle) {
      _mapStyle = mapStyle;
      googleMapController.setMapStyle(_mapStyle);
    });
  }
}
