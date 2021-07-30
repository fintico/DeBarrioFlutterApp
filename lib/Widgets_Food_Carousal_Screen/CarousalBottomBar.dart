/* import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ModelClass/orderList.dart';
import 'package:debarrioapp/Screens/cart.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarCarousal extends StatefulWidget {
  final PostedDish postedDish;
  final bool isDelivery;
  final User selectedRestaurant;

  BottomBarCarousal(this.postedDish, this.isDelivery, this.selectedRestaurant);

  @override
  _BottomBarCarousalState createState() => _BottomBarCarousalState();
}

class _BottomBarCarousalState extends State<BottomBarCarousal> {
  int _increment = 0;
  OrderList orderList;
  User user;

  String calculatePrice() {
    return widget.isDelivery
        ? ((double.parse(widget.postedDish.priceWithDelivery) +
                    getAdditionDishPriceForPosted(widget.postedDish)) *
                _increment)
            .toStringAsFixed(2)
        : ((double.parse(widget.postedDish.originalPrice) +
                    getAdditionDishPriceForPosted(widget.postedDish)) *
                _increment)
            .toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    orderList = Provider.of<OrderList>(context);
    user = Provider.of<User>(context);
    return Stack(
      overflow: Overflow.visible,
      alignment: new FractionalOffset(.5, 1.0),
      children: [
        new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 35,
                              width: 35,
                              child: FloatingActionButton(
                                heroTag: Text("btncaro1"),
                                elevation: 0.0,
                                onPressed: () {
                                  if (_increment > 0) {
                                    setState(() {
                                      _increment--;
                                    });
                                  }
                                },
                                child: Text("-",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.black)),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              child: Text(
                                _increment.toString(),
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 35,
                              width: 35,
                              child: FloatingActionButton(
                                heroTag: Text("btncaro2"),
                                elevation: 0.0,
                                onPressed: () {
                                  setState(() {
                                    _increment++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Agregar Padedo S/${calculatePrice()}",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () async {
                          if (_increment == 0) return;
                          if (orderList.order == null) {
                            orderList.order = Order();
                            orderList.myOrders = [];
                            orderList.order.id =
                                await DatabaseService().getRandomId();
                            orderList.order.buyerId = user.id;
                            orderList.order.salesDate = DateTime.now();
                            orderList.order.originalPrice = '0';
                          }
                          OrderedDish ordered =
                              getOrderedFromPosted(widget.postedDish);
                          ordered.buyerId = user.id;
                          ordered.quantity = _increment;
                          ordered.makerId = widget.selectedRestaurant.id;
                          ordered.orderId = orderList.order.id;
                          ordered.additionDish = widget.postedDish.additionDish
                              .where((element) => element.isSelected)
                              .toList();
                          ordered.originalPrice = calculateUnitPrice();
                          ordered.isDelivery = widget.isDelivery;
                          orderList.myOrders.add(ordered);
                          orderList.order.originalPrice =
                              getCurrentOrderListPrice(orderList);
                          setState(() {
                            _increment = 0;
                          });
                          final snackBar = SnackBar(
                            backgroundColor: Colors.pink[50],
                            duration: Duration(seconds: 2),
                            padding: EdgeInsets.all(8.0),
                            content: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Agregado al carrito de compras',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            action: SnackBarAction(
                              label: 'Ver Todo',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => FoodCart()));
                              },
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String calculateUnitPrice() {
    return widget.isDelivery
        ? widget.postedDish.priceWithDelivery
        : widget.postedDish.originalPrice;
  }
}
 */
