/* import 'dart:developer';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ModelClass/foodData.dart';
import 'package:debarrioapp/ModelClass/orderList.dart';
import 'package:debarrioapp/Screens/calendar_splash.dart';
import 'package:debarrioapp/Screens/cart.dart';
import 'package:debarrioapp/Screens/nav_drawer.dart';
import 'package:debarrioapp/Screens/search_icon_screen.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/WdgetsMapScreen/FoodList.dart';
import 'package:debarrioapp/icons/my_flutter_app_icons.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_three.dart';
import 'package:debarrioapp/widgets/components/icons/filter.dart';
import 'package:debarrioapp/widgets/components/transitions/slide_right_transition.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geodesy/geodesy.dart' as GeoDesy;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../utilsFunctions.dart';
import 'calender_timeline.dart';
import 'food_search_filter_screen.dart';
import 'paysplash.dart';

class Customer {
  String name;
  int age;

  Customer(this.name, this.age);
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController myMapController;
  Set<Marker> _markers = new Set();
  User user;
  bool loading = true;
  DatabaseService database = DatabaseService();
  List<PostedDish> postedDishes = [];
  List<User> restaurants = [];
  FoodData foodData;
  Map<String, List<PostedDish>> restaurantName = Map();
  List customers = [];
  //List<String> post = [];

  List<String> litems = [
    "1",
    "2",
    "Third",
  ];

  /// This stores the current position for the selected user
  Position currentPosition;
  OrderList orderList;

  static const LatLng _mainLocation = const LatLng(24.8607, 67.0011);

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }

  @override
  void initState() {
    super.initState();
    getAllPostedDish();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setPosition(
        Position(
          /* latitude: user.address[0].addressLanLon.latitude,
          longitude: user.address[0].addressLanLon.longitude, */
          latitude: userAppData.latitude,
          longitude: userAppData.longitude,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    foodData = Provider.of<FoodData>(context, listen: false);
    setPosition(
      Position(
        /* latitude: user.address[0].addressLanLon.latitude,
        longitude: user.address[0].addressLanLon.longitude, */
        latitude: userAppData.latitude,
        longitude: userAppData.longitude,
      ),
    );

    orderList = Provider.of<OrderList>(context);
    //var address = user.address[0].addressString;
    var address = userAppData.address;
    //var addressShort = address.split(",");
    //print(addressShort[0]);
    customers.add(Customer('Jack', 23));
    customers.add(Customer('Adam', 27));
    customers.add(Customer('Katherin', 25));
    inspect(customers);
    /* final appBar = AppBar(
      leading: IconButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NavDrawer()))
        },
        icon: Icon(
          MyFlutterApp.menu,
          size: 30,
        ),
      ),
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
        IconButton(
          iconSize: 25,
          alignment: Alignment.centerRight,
          color: Colors.white,
          icon: Icon(MyFlutterApp.money),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CalendarTimeline()));
          },
        ),
        IconButton(
          iconSize: 25,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            if (cZeroStr(orderList.myOrders)) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FoodCart()));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PaySplash()));
            }
          },
        ),
      ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.pointer,
                              color: Colors.green,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                user.address[0].addressString,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.0),
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Row(
                        children: [
                          Icon(
                            MyFlutterApp.angle_down,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    ); */
    final appBar = PreferredSize(
      child: Container(
        child: AppBarOptionThree(
          leftIconAction: () {
            Navigator.push(context, SlideRightRoute(page: NavDrawer()));
          },
          rightIconAction: () {
            if (cZeroStr(orderList.myOrders)) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FoodCart()));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PaySplash()));
            }
          },
          secondaryIconAction: () {
            Navigator.push(
                //context, MaterialPageRoute(builder: (_) => CalendarTimeline()));
                context,
                MaterialPageRoute(builder: (_) => CalendarSplash()));
          },
          subTitleIconAction: () {},
          subTitle: address,
        ),
      ),
      preferredSize: Size.fromHeight(104.0),
    );
    return loading
        ? SizedBox(
            height: 10,
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: HexColor("#FBFCFC"),
              appBar: appBar,
              body: LoadingOverlay(
                isLoading: loading,
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
                            initialCameraPosition: CameraPosition(
                              target: _mainLocation,
                              zoom: 10.0,
                            ),
                            markers: _markers,
                            mapType: MapType.normal,
                            onMapCreated: (controller) {
                              setState(() {
                                myMapController = controller;
                                moveCamera(currentPosition.latitude,
                                    currentPosition.longitude);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 16.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                readOnly: true,
                                onFieldSubmitted: (value) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SearchModalSheet(
                                                  forMap: false,
                                                )),
                                      ),
                                    },
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: "¿Qué se te antoja hoy?",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: IconButton(
                                icon: FilterIcon(
                                  height: 24.0,
                                  width: 24.0,
                                  type: 0,
                                ),
                                onPressed: () => Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                    builder: (_) => FoodSearchFilterScreen(
                                        setCategory: setCategory),
                                  ),
                                ),
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                        if (litems.isNotEmpty)
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: litems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(litems[index]);
                              /* return FoodItemList(customer: customers[index]
                                  /*  postedDishes: postedDishes
                                    .where((element) =>
                                        element.makerId == customers[index].age)
                                    .toList(), */
                                  ); */
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  setPosition(Position position) {
    if (currentPosition == null || currentPosition != position) {
      currentPosition = position;
      moveCamera(currentPosition.latitude, currentPosition.longitude);
    }
  }

  void moveCamera(lat, lng) {
    myMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.0,
        ),
      ),
    );
  }

  void setCategory(List<String> categories, List<DateTime> dates) {
    postedDishes = [];
    restaurants = [];
    if (dates.length > 0) {
      postedDishes = foodData.dishesData.where((selectedDish) {
        if (dates.lastIndexWhere((element) =>
                element.day == selectedDish.startTime.day &&
                element.month == selectedDish.startTime.month &&
                element.year == selectedDish.startTime.year) !=
            -1) {
          if (categories.length == 0) return true;
          if (categories.contains(selectedDish.category)) return true;
        }
        return false;
      }).toList();
      restaurants = foodData.restaurantData
          .where((element) =>
              postedDishes
                  .indexWhere((posted) => posted.makerId == element.id) !=
              -1)
          .toList();

      inspect(restaurants);
      print('Aea');
      print(restaurants);
    } else if (categories.length > 0) {
      postedDishes = foodData.dishesData
          .where((element) => categories.contains(element.category))
          .toList();
      restaurants = foodData.restaurantData
          .where((element) =>
              postedDishes
                  .indexWhere((posted) => posted.makerId == element.id) !=
              -1)
          .toList();
    } else {
      postedDishes.addAll(foodData.dishesData);
      restaurants.addAll(foodData.restaurantData);
    }
    if (restaurants.length == 0) {
      Fluttertoast.showToast(
          msg: "No dish found according to the filter",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      postedDishes.addAll(foodData.dishesData);
      restaurants.addAll(foodData.restaurantData);
    }
  }

  void getAllPostedDish() {
    database.getAllPostedDishes().listen((allDishes) {
      restaurants = [];
      postedDishes = [];
      foodData.dishesData = [];
      foodData.restaurantData = [];
      _markers = Set<Marker>();
      foodData.dishesData.addAll(allDishes
          .where((element) => element.salesDate.isAfter(DateTime.now()))
          .toList());
      postedDishes.addAll(allDishes
          .where((element) => element.salesDate.isAfter(DateTime.now()))
          .toList());
      for (PostedDish posted in foodData.dishesData) {
        database.getOtherUserData(posted.makerId).listen((currentRestaurant) {
          setRestaurant(currentRestaurant, posted);
          setRestaurantMarker(currentRestaurant, posted);
        });
      }

      print(restaurants);
      print(postedDishes);
      print('all');
      inspect(restaurants);
      inspect(postedDishes);

      if (foodData.dishesData.isEmpty)
        setState(() {
          loading = false;
        });
    });
  }

  void setRestaurant(User currentRestaurant, PostedDish posted) {
    int index = foodData.restaurantData.indexWhere((element) =>
        element.restaurantName == currentRestaurant.restaurantName);
    if (index == -1 && currentPosition != null) {
      currentRestaurant.distance = getDistance(currentPosition, posted);
      if (currentRestaurant.distance < 5000) {
        foodData.restaurantData.add(currentRestaurant);
        restaurants.add(currentRestaurant);
      }
    }
  }

  void setRestaurantMarker(User event, PostedDish posted) {
    if (restaurantName.containsKey(
        '${posted.currentLocation.longitude}+${posted.currentLocation.latitude}')) {
      restaurantName[
              '${posted.currentLocation.longitude}+${posted.currentLocation.latitude}']
          .add(posted);
    } else {
      restaurantName[
          '${posted.currentLocation.longitude}+${posted.currentLocation.latitude}'] = [
        posted
      ];
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(posted.id),
            infoWindow: InfoWindow(
              title: event.restaurantName,
              snippet: '${event.reviews} Star Rating',
            ),
            position: LatLng(posted.currentLocation.latitude,
                posted.currentLocation.longitude)));
      });
      setState(() {
        loading = false;
      });
    }
  }

  int getDistance(Position currentPosition, PostedDish posted) {
    return GeoDesy.Geodesy()
        .distanceBetweenTwoGeoPoints(
            GeoDesy.LatLng(currentPosition.latitude, currentPosition.longitude),
            GeoDesy.LatLng(posted.currentLocation.latitude,
                posted.currentLocation.longitude))
        .round();
  }
}
 */
