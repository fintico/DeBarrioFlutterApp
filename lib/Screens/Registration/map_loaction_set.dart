import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:da_brello_ui/ModelClass/AddressModel.dart';
import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Screens/map_screen.dart';
import 'package:da_brello_ui/Screens/search_icon_screen.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../utilsFunctions.dart';

class LocationSetter extends StatefulWidget {
  final bool fromUserProfile;
  final int indexToChange;

  const LocationSetter({Key key, this.fromUserProfile, this.indexToChange})
      : super(key: key);

  @override
  _LocationSetterState createState() => _LocationSetterState();
}

class _LocationSetterState extends State<LocationSetter> {
  GoogleMapController myMapController;
  Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(24.8607, 67.0011);

  /// This is the api to database
  DatabaseService database = DatabaseService();

  /// Get current user data
  User user;
  InAppAddress inAppAddress;
  TextEditingController _text = TextEditingController();
  bool loading = false;

  /// This service is used to get the current location from the user
  Geolocator geoLocator = Geolocator();

  /// This stores the current position for the selected user
  Position currentPosition;

  // Set<Marker> myMarker() {
  //   setState(() {
  //     _markers.add(Marker(
  //       // This marker id can be anything that uniquely identifies each marker.
  //       markerId: MarkerId(_mainLocation.toString()),
  //       position: _mainLocation,
  //       infoWindow: InfoWindow(
  //         title: 'Historical City',
  //         snippet: '5 Star Rating',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  //
  //   return _markers;
  // }

  @override
  void initState() {
    super.initState();
    getLocationPermission(setPosition);
    Fluttertoast.showToast(
        msg: "Please click on the map where you want to set up location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    final appBar = AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.black87,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        child: Row(
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
      ),
      centerTitle: true,
      bottom: PreferredSize(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 0.8,
                color: Colors.white,
                endIndent: 22.0,
                indent: 22,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                      child: Text("Confirma tu unaniciaon",
                          style:
                              TextStyle(color: Colors.amber, fontSize: 20)))),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#FBFCFC"),
        appBar: appBar,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                setUserLocation();
              },
              child: Text("CONFIRMAR"),
              textColor: Colors.white,
            ),
          ),
        ),
        body: LoadingOverlay(
          color: Colors.black,
          opacity: .7,
          isLoading: loading,
          progressIndicator: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            color: Colors.white,

          ),
          child: Container(
            height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top),
            width: (MediaQuery.of(context).size.width),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: _mainLocation,
                        zoom: 10.0,
                      ),
                      markers: _markers,
                      onTap: setCurrentMarkerFromCoordinates,
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        setState(() {
                          myMapController = controller;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: Text(
                        "?Donde te encuentras",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _text,
                      readOnly: true,
                      onFieldSubmitted: (value) {
                        getLocationCoOrdinatesWithAddress(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SearchModalSheet(
                                        setCurrentMarkerFromCoordinates:
                                            setCurrentMarkerFromCoordinates,
                                        getLocationCoOrdinatesWithAddress:
                                            getLocationCoOrdinatesWithAddress,
                                        forMap: true,
                                      )),
                            ),
                          },
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Que se te antoja hoy?",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: Text(
                        "Nro.de Appartmenta/Piso",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      readOnly: false,
                      onChanged: (value) {
                        inAppAddress.addressDescription = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Ejemplo:Appartmento",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Set current location when user search for a place
  Future<void> getLocationCoOrdinatesWithAddress(String addressQuery) async {
    setLoading(true);
    var address = await Geocoder.local.findAddressesFromQuery(addressQuery);
    var first = address.first;
    setMarker(first);
  }

  ///Set current location when user click on a location on map
  Future<void> setCurrentMarkerFromCoordinates(LatLng argument) async {
    setLoading(true);
    var address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(argument.latitude, argument.longitude));
    var first = address.first;
    setMarker(first);
  }

  void setUserLocation() {
    if (inAppAddress != null) {
      if (!widget.fromUserProfile) {
        user.address = [];
        user.address.add(inAppAddress);
        database.setUserData(user);
        gotoMapScreen();
      } else {
        if (widget.indexToChange == -1) {
          user.address.add(inAppAddress);
        } else {
          user.address[widget.indexToChange]=inAppAddress;
          // ignore: invalid_use_of_visible_for_testing_member
          user.notifyListeners();
        }
        database.setUserData(user);
        Navigator.pop(context);
      }
    }
  }

  void gotoMapScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => MapScreen()),(Route<dynamic> route)=>false);

  }

  void moveCamera(lat, lng) {
    myMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.0,
        ),
      ),
    );
  }

  void setMarker(Address first) {
    _markers = Set();
    inAppAddress = InAppAddress(
        addressId: Uuid().v4(),
        addressLanLon:
            GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
        addressString: first.addressLine);
    moveCamera(first.coordinates.latitude, first.coordinates.longitude);
    setState(() {
      _text.text = first.addressLine;
      setLoading(false);
      _markers.add(Marker(
          markerId: MarkerId('current Location'),
          position:
              LatLng(first.coordinates.latitude, first.coordinates.longitude),
          infoWindow: InfoWindow(
              title: 'My pickup location',
              snippet: inAppAddress.addressString)));
    });
  }

  void setLoading(bool bool) {
    setState(() {
      loading = bool;
    });
  }


  setPosition(Position position) {
    currentPosition = position;
    print('CURRENT POS: $currentPosition');
    setState(() {
      moveCamera(position.latitude, position.longitude);
    });
  }
}
