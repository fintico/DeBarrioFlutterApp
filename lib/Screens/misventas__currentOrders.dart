/* import 'dart:io';

import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/OrderActive.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'CartActive.dart';

class Misventas extends StatefulWidget {
  final bool isCurrentOrders;

  const Misventas({Key key, this.isCurrentOrders}) : super(key: key);

  @override
  MisventasState createState() => MisventasState();
}

class MisventasState extends State<Misventas> {
  bool loading = true;
  DatabaseService databaseService = DatabaseService();
  List<PostedDish> currentDishes = [];
  List<Order> currentOrder = [];
  PostedDish selectedPostedDish = PostedDish();
  User user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isCurrentOrders)
        getCurrentUserOrders();
      else
        getCurrentUserPostedDishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    selectedPostedDish = Provider.of<PostedDish>(context);
    /* final appBar = AppBar(
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
          iconSize: 35,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      centerTitle: true,
      bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: Text(
                    "Mis ventas",
                    style: TextStyle(
                      color: Colors.yellowAccent[700],
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    ); */
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Mis ventas',
          leftIconAction: () => Navigator.pop(context),
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar,
          body: LoadingOverlay(
            color: Colors.black,
            opacity: .7,
            isLoading: loading,
            progressIndicator: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              color: Colors.white,
            ),
            child: !loading
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      // the tab bar with two items
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: AppBar(
                            backgroundColor: Colors.white,
                            elevation: 0.0,
                            bottom: TabBar(
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              tabs: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Tab(
                                    text: "Activas",
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Tab(
                                    text: "Finalizadas",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // first tab bar view widget
                            if (widget.isCurrentOrders)
                              CartOrderActive(
                                  currentOrders: currentOrder.where((input) {
                                var compare = DateTime(input.salesDate.year,
                                    input.salesDate.month, input.salesDate.day);
                                return compare.isAtSameMomentAs(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day));
                              }).toList()),
                            if (widget.isCurrentOrders)
                              CartOrderActive(
                                  currentOrders: currentOrder.where((input) {
                                var compare = DateTime(input.salesDate.year,
                                    input.salesDate.month, input.salesDate.day);
                                return compare.isBefore(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day));
                              }).toList()),
                            if (!widget.isCurrentOrders)
                              CartActive(
                                  currentDishes: currentDishes
                                      .where((input) => input.salesDate
                                          .isAfter(DateTime.now()))
                                      .toList()),
                            if (!widget.isCurrentOrders)
                              CartActive(
                                  currentDishes: currentDishes
                                      .where((input) => input.salesDate
                                          .isBefore(DateTime.now()))
                                      .toList())
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 10,
                  ),
          ),
        ),
      ),
    );
  }

  void getCurrentUserPostedDishes() {
    databaseService.getAllPostedDishesForUser(user.id).listen((event) {
      currentDishes = [];
      currentDishes.addAll(event);
      setState(() {
        loading = false;
      });
    });
  }

  void getCurrentUserOrders() {
    databaseService.getSelectedUserOrders(user.id).listen((event) {
      currentOrder = [];
      currentOrder.addAll(event);
      setState(() {
        loading = false;
      });
    });
  }
}
 */
