/* import 'package:auto_suggestion_text_field/model/text_field_prop.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:debarrioapp/Icons/my_flutter_app_icons.dart';
import 'package:debarrioapp/ModelClass/foodData.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import 'calender_timeline.dart';
import 'food_carousel.dart';
import 'paysplash.dart';

class SearchModalSheet extends StatefulWidget {
  final Function getLocationCoOrdinatesWithAddress;
  final Function setCurrentMarkerFromCoordinates;
  final bool forMap;

  const SearchModalSheet(
      {Key key,
      this.getLocationCoOrdinatesWithAddress,
      this.forMap,
      this.setCurrentMarkerFromCoordinates})
      : super(key: key);

  @override
  _SearchModalSheetState createState() => _SearchModalSheetState();
}

class _SearchModalSheetState extends State<SearchModalSheet> {
  TextEditingController _location = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  FoodData foodData;

  /// This stores the current position for the selected user
  Position currentPosition;

  TextEditingController text = TextEditingController();
  String currentValue = null;

  @override
  Widget build(BuildContext context) {
    foodData = Provider.of<FoodData>(context, listen: false);
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
      actions: [
        if (widget.forMap)
          IconButton(
            iconSize: 25,
            alignment: Alignment.centerRight,
            color: Colors.white,
            icon: Icon(MyFlutterApp.money),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CalendarTimeline()));
            },
          ),
        if (widget.forMap)
          IconButton(
            iconSize: 25,
            alignment: Alignment.centerRight,
            color: Colors.white,
            padding: const EdgeInsets.only(right: 14.0),
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PaySplash()));
            },
          ),
      ],
      centerTitle: true,
    );
    return Scaffold(
      backgroundColor: HexColor("#f2f2f2"),
      appBar: appBar,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            color: Colors.redAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {},
            child: Text("Agregar adiciones"),
            textColor: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          width: (MediaQuery.of(context).size.width),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SimpleAutocompleteFormField<String>(
                  decoration: InputDecoration(
                      labelText: 'Ingresa tu direccion',
                      border: OutlineInputBorder()),
                  suggestionsHeight: 80.0,
                  itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  ),
                  onSearch: (search) => widget.forMap
                      ? getAddressFromSearch(search)
                      : getRestaurantNameFromSearch(search),
                  minSearchLength: widget.forMap ? 5 : 2,
                  onChanged: widget.forMap
                      ? setMapLocationSuggestion
                      : setRestaurantLocationSuggestion,
                  validator: validateAddress,
                  // itemFromString: (string) => print(string),
                ),
              ),
              if (widget.forMap)
                Container(
                  child: RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      checkPermissionAndSetLocation();
                    },
                    child: Text("Utilizar mi ubicación Actual"),
                    textColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> getRestaurantNameFromSearch(String search) async {
    var value = foodData.restaurantData
        .where((element) => element.restaurantName.contains(search))
        .toList()
        .map((e) => e.restaurantName)
        .toList();
    if (value.length == 0) value = ['Not Found'];
    return value;
  }

  Future<List<String>> getAddressFromSearch(String search) async {
    try {
      var address = await Geocoder.local.findAddressesFromQuery(search);
      return address.map((e) => e.addressLine).toList();
    } on Exception catch (e) {
      print(e);
      return ['Not Found'];
    }
  }

  void setMapLocationSuggestion(String value) {
    if (value != null && value != 'Not Found') {
      Navigator.pop(context);
      widget.getLocationCoOrdinatesWithAddress(value);
    }
  }

  void setRestaurantLocationSuggestion(String value) {
    if (value != null && value != 'Not Found') {
      var selectedRestaurant = foodData.restaurantData
          .firstWhere((element) => element.restaurantName == value);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => RestaurantCarouselSlider(
                    selectedRestaurant: selectedRestaurant,
                    postedDishes: foodData.dishesData
                        .where((element) =>
                            element.makerId == selectedRestaurant.id)
                        .toList(),
                  )));
    }
  }

  String validateAddress(String value) {
    return value == null ? 'No place found.' : null;
  }

  Future<void> checkPermissionAndSetLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) getCurrentLocation();
  }

  /// This is called when the permission is accepted and we need to get user current position to show on map
  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((Position position) async {
      currentPosition = position;
      Navigator.pop(context);
      widget.setCurrentMarkerFromCoordinates(
          LatLng(currentPosition.latitude, currentPosition.longitude));
      // notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }
}
 */
