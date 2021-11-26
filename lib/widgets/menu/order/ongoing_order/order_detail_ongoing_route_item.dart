import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../utilsFunctions.dart';

class OrderDetailOngoingRoute extends StatefulWidget {
  OrderDetailOngoingRoute({Key? key}) : super(key: key);

  @override
  _OrderDetailOngoingRouteState createState() =>
      _OrderDetailOngoingRouteState();
}

class _OrderDetailOngoingRouteState extends State<OrderDetailOngoingRoute> {
  GoogleMapController? mapController;
  BitmapDescriptor? customStartMark;
  BitmapDescriptor? customDestinationMark;
  CameraPosition? _initialLocation;
  Set<Marker> markers = {};
  String? _mapStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await _setIconStartMarker();
      await _setIconDestinatioMarker();
      /* await rootBundle.loadString('assets/map_style.txt').then((string) {
        _mapStyle = string;
      }); */
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    double? latStart = //-12.089114550550791;
        orderBloc.orderDetail!.dish!.address!.latitude;
    double? lngStart = //-77.07022860227016;
        orderBloc.orderDetail!.dish!.address!.longitude;

    double? latDestination = //-12.090008898541878;
        orderBloc.orderDetail!.order!.customerAddress!.address!.latitude;
    double? lngDestination = //-77.06993355923846;
        orderBloc.orderDetail!.order!.customerAddress!.address!.longitude;

    _setStartMarker(latStart!, lngStart!);
    _setDestinationMarker(latDestination!, lngDestination!);
    return Container(
      height: screenHeight(context, dividedBy: 1.8),
      child: _map(),
    );
  }

  _map() {
    return GoogleMap(
      initialCameraPosition: _initialLocation!,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      buildingsEnabled: true,
      mapType: MapType.normal,
      markers: markers,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: onMapCreatedEvent,
      trafficEnabled: false,
      indoorViewEnabled: false,
    );
  }

  /* _onMapCreated(GoogleMapController controller) {
    //if (mounted)
    setState(() {
      mapController = controller;
      controller.setMapStyle(_mapStyle);
    });
  } */

  _setStartMarker(double lat, double lng) {
    //setState(() {
    Marker startMarker = Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        lat,
        lng,
      ),
      icon: customStartMark!,
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
      icon: customDestinationMark!,
    );
    markers.add(destinationMarker);
  }

  _setIconStartMarker() async {
    await getBytesFromAsset('assets/icons/my_location.png', 64)
        .then((value) => customStartMark = BitmapDescriptor.fromBytes(value));
  }

  _setIconDestinatioMarker() async {
    //setState(() {
    await getBytesFromAsset('assets/icons/placeholder.png', 84).then(
        (value) => customDestinationMark = BitmapDescriptor.fromBytes(value));
    //});
  }

  void onMapCreatedEvent(controller) {
    mapController = controller;
    _loadMapStyle(mapController!);
  }

  void _loadMapStyle(GoogleMapController googleMapController) {
    rootBundle.loadString('assets/map_style.json').then((mapStyle) {
      _mapStyle = mapStyle;
      googleMapController.setMapStyle(_mapStyle);
    });
  }
}
