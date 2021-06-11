import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utilsFunctions.dart';

class RouteDeliveryPage extends StatefulWidget {
  final OrderDetail orderDetail;
  const RouteDeliveryPage({Key key, this.orderDetail}) : super(key: key);

  @override
  _RouteDeliveryPageState createState() => _RouteDeliveryPageState();
}

class _RouteDeliveryPageState extends State<RouteDeliveryPage> {
  GoogleMapController mapController;
  BitmapDescriptor customStartMark;
  BitmapDescriptor customDestinationMark;
  CameraPosition _initialLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _setIconStartMarker();
    _setIconDestinatioMarker();
  }

  //Geolocator _geolocator = Geolocator();
  Position _currentPosition;
  @override
  Widget build(BuildContext context) {
    double latStart = widget.orderDetail.dish.address.latitude;
    double lngStart = widget.orderDetail.dish.address.longitude;

    double latDestination =
        widget.orderDetail.order.customerAddress.address.latitude;
    double lngDestination =
        widget.orderDetail.order.customerAddress.address.longitude;

    _setStartMarker(latStart, lngStart);
    _setDestinationMarker(latDestination, lngDestination);
    return Container(
      height: screenHeight(context, dividedBy: 3.0),
      child: Stack(
        children: [
          _map(),
          //_zoomBotton(),
        ],
      ),
    );
  }

  _map() {
    return GoogleMap(
      initialCameraPosition: _initialLocation,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      buildingsEnabled: false,
      mapType: MapType.terrain,
      markers: markers,
      //markers: markers != null ? Set<Marker>.from(markers) : null,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        //mapController = controller;
        setState(() {
          mapController = controller;
        });
      },
    );
  }

  _zoomBotton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: Colors.orange, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(Icons.my_location),
              ),
              onTap: () {
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        _currentPosition.latitude,
                        _currentPosition.longitude,
                      ),
                      zoom: 18.0,
                    ),
                  ),
                );
                ;
              },
            ),
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    setState(() {
      // Store the position in the variable
      //_currentPosition = position;
      //_setStartMarker(position.latitude, position.longitude);
      print('CURRENT POS: $_currentPosition');
      // For moving the camera to current location
      //_initialLocation = CameraPosition(target: LatLng(lat, lng), zoom: 15.0);
      getBytesFromAsset('assets/icons/my_location.png', 64)
          .then((value) => customStartMark = BitmapDescriptor.fromBytes(value));
      /* getBytesFromAsset('assets/icons/placeholder.png', 84).then(
          (value) => customDestinationMark = BitmapDescriptor.fromBytes(value)); */
      _setStartMarker(widget.orderDetail.dish.address.latitude,
          widget.orderDetail.dish.address.longitude);
      _setDestinationMarker(
          widget.orderDetail.order.customerAddress.address.latitude,
          widget.orderDetail.order.customerAddress.address.longitude);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.orderDetail.dish.address.latitude,
                widget.orderDetail.dish.address.longitude),
            zoom: 10.0,
          ),
        ),
      );
    });
    /* await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      
    }).catchError((e) {
      print(e);
    }); */
  }

  _setStartMarker(double lat, double lng) {
    //setState(() {
    Marker startMarker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        lat,
        lng,
      ),
      /* infoWindow: InfoWindow(
        title: 'Start',
        snippet: _startAddress,
      ), */
      icon: customStartMark,
    );
    markers.add(startMarker);
    _initialLocation = CameraPosition(target: LatLng(lat, lng), zoom: 15.0);

    //});
  }

  _setDestinationMarker(double lat, double lng) {
    Marker destinationMarker = Marker(
      markerId: MarkerId('2'),
      position: LatLng(
        lat,
        lng,
      ),
      /* infoWindow: InfoWindow(
        title: 'Start',
        snippet: _startAddress,
      ), */
      icon: customDestinationMark,
    );
    markers.add(destinationMarker);
  }

  _setIconStartMarker() {
    getBytesFromAsset('assets/icons/my_location.png', 64)
        .then((value) => customStartMark = BitmapDescriptor.fromBytes(value));
  }

  _setIconDestinatioMarker() {
    setState(() {
      getBytesFromAsset('assets/icons/placeholder.png', 84).then(
          (value) => customDestinationMark = BitmapDescriptor.fromBytes(value));
    });
  }
}
