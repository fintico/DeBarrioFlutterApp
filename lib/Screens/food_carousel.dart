import 'package:da_brello_ui/ModelClass/OrderModel.dart';
import 'package:da_brello_ui/ModelClass/OrderedDish.dart';
import 'package:da_brello_ui/ModelClass/PostedDishModel.dart';
import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/ModelClass/orderList.dart';
import 'package:da_brello_ui/Screens/paysplash.dart';
import 'package:da_brello_ui/Widgets_Food_Carousal_Screen/CarousalAfterRadioText.dart';
import 'package:da_brello_ui/Widgets_Food_Carousal_Screen/CarousalBottomBar.dart';
import 'package:da_brello_ui/Widgets_Food_Carousal_Screen/CarousalRadioBtn.dart';
import 'package:da_brello_ui/Widgets_Food_Carousal_Screen/CarousalSlider.dart';
import 'package:da_brello_ui/Widgets_Food_Carousal_Screen/listitem.dart';
import 'package:da_brello_ui/utilsFunctions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class RestaurantCarouselSlider extends StatefulWidget {
  final List<PostedDish> postedDishes;
  final User selectedRestaurant;

  const RestaurantCarouselSlider(
      {Key key, this.postedDishes, this.selectedRestaurant})
      : super(key: key);

  @override
  _RestaurantCarouselSliderState createState() =>
      _RestaurantCarouselSliderState();
}

class _RestaurantCarouselSliderState extends State<RestaurantCarouselSlider> {
  int selectedIndex = 0;
  bool isDelivery = true;
  OrderedDish orderedDish=OrderedDish();
  OrderList cartOrder;

  @override
  Widget build(BuildContext context) {
    cartOrder=Provider.of<OrderList>(context);
    final appBar = AppBar(
      leading: IconButton(
        iconSize: 25,
        alignment: Alignment.centerRight,
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
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
          icon: Icon(Icons.calendar_today_outlined),
          // onPressed: () => {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (_) => CalendarTimeline()))
          // },
        ),
        IconButton(
          iconSize: 25,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            if (cZeroStr(cartOrder.myOrders)) {
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
    );
    return Scaffold(
      backgroundColor: HexColor("#f2f2f2"),
      appBar: appBar,
      bottomNavigationBar: BottomBarCarousal(widget.postedDishes[selectedIndex],isDelivery,widget.selectedRestaurant),
      body: Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ItemList(currentRestaurant: widget.selectedRestaurant),
              CarousalSliderWidget(
                currentPostedDish: widget.postedDishes,
                setIndex: setCurrentIndex,
              ),
              DotsIndicator(
                dotsCount: widget.postedDishes.length,
                position: selectedIndex.ceilToDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.grey[600],
                  color: Colors.grey[300]

                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(
                      "${widget.postedDishes[selectedIndex].name}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[600]),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Text(
                      isDelivery
                          ? "S/${widget.postedDishes[selectedIndex].priceWithDelivery}.00"
                          : "S/${widget.postedDishes[selectedIndex].originalPrice}.00",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RadioCarousal(setOrderType: setOrderType),
              ),
              SizedBox(height: 30),
              AfterRadioCarousal(widget.postedDishes[selectedIndex]),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  children: [
                    if (cZeroStr(widget.postedDishes[selectedIndex].additionDish))
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.postedDishes[selectedIndex].additionDish.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: CheckboxListTile(
                              title: Text(widget.postedDishes[selectedIndex].additionDish[index].additionName),
                              value: widget.postedDishes[selectedIndex].additionDish[index].isSelected,
                              activeColor: Colors.green,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.postedDishes[selectedIndex].additionDish[index].isSelected = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 0.05,
                    //     child: CheckboxListTile(
                    //       activeColor: Colors.green,
                    //       title: Text("Ensalada de verduras"),
                    //       value: _selected2,
                    //       onChanged: (newValue) {
                    //         setState(() {
                    //           _selected2 = newValue;
                    //         });
                    //       },
                    //       controlAffinity: ListTileControlAffinity
                    //           .leading, //  <-- leading Checkbox
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 0.05,
                    //     child: CheckboxListTile(
                    //       title: Text("Aji especial"),
                    //       value: _selected3,
                    //       activeColor: Colors.green,
                    //       onChanged: (newValue) {
                    //         setState(() {
                    //           _selected3 = newValue;
                    //         });
                    //       },
                    //       controlAffinity: ListTileControlAffinity
                    //           .leading, //  <-- leading Checkbox
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 0.05,
                    //     child: CheckboxListTile(
                    //       title: Text("Crema huancaina"),
                    //       value: _selected4,
                    //       activeColor: Colors.green,
                    //       onChanged: (newValue) {
                    //         setState(() {
                    //           _selected4 = newValue;
                    //         });
                    //       },
                    //       controlAffinity: ListTileControlAffinity
                    //           .leading, //  <-- leading Checkbox
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  setCurrentIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  setOrderType(int index) {
    setState(() {
      isDelivery = index == 0;
    });
  }
}
