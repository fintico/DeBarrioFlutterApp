/* import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ModelClass/orderList.dart';
import 'package:debarrioapp/Screens/payoptbutton.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../utilsFunctions.dart';
import 'agregormetodo_addCardScreen.dart';
import 'creditcard_info__add_new_credit_card.dart';
import 'orderCompletion_done.dart';

class FoodCart extends StatefulWidget {
  @override
  FoodCartState createState() => FoodCartState();
}

class FoodCartState extends State<FoodCart> {
  OrderList orderList;
  User user;

  @override
  Widget build(BuildContext context) {
    orderList = Provider.of<OrderList>(context);
    user = Provider.of<User>(context);
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () => {},
        icon: Icon(Icons.arrow_back_ios),
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
          onPressed: () {},
        ),
        IconButton(
          iconSize: 25,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
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
                child: Center(
                  child: Text(
                    "Carrito de Compras",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: HexColor("#f2f2f2"),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Total : S/${orderList.order.originalPrice}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        if (cZeroStr(user.cards))
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PayOptButton(
                                        fromOrder: true,
                                      )));
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AgregorMetodo(
                                        fromOrder: true,
                                      )));
                        }
                      },
                      child: Text("Continuar con el pago"),
                      elevation: 0.0,
                      color: HexColor('E84A31'),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderList.myOrders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Colors.red,
                            height: 50,
                            width: 50,
                            child: Image(
                              fit: BoxFit.cover,
                              image: cZeroStr(
                                      orderList.myOrders[index].dishPictureURI)
                                  ? NetworkImage(
                                      orderList.myOrders[index].dishPictureURI)
                                  : AssetImage(
                                      'assets/images/carouselfirst.png'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.only(left: 16.0, top: 32.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orderList.myOrders[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "S/ ${calculatePriceForDish(orderList.myOrders[index])}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.amber,
                                  thickness: 1,
                                  indent: 200,
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "La Buenza Sazon",
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: FloatingActionButton(
                                        heroTag: Text("btn2"),
                                        backgroundColor: Colors.grey[200],
                                        onPressed: () {
                                          setState(() {
                                            orderList
                                                .myOrders[index].quantity++;
                                            orderList.order.originalPrice =
                                                getCurrentOrderListPrice(
                                                    orderList);
                                          });
                                        },
                                        elevation: 0.0,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    Text(
                                        orderList.myOrders[index].quantity
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: FloatingActionButton(
                                          heroTag: Text("btn1"),
                                          backgroundColor: Colors.grey[200],
                                          onPressed: () {
                                            setState(() {
                                              if (orderList.myOrders[index]
                                                      .quantity >
                                                  1)
                                                orderList
                                                    .myOrders[index].quantity--;
                                              orderList.order.originalPrice =
                                                  getCurrentOrderListPrice(
                                                      orderList);
                                            });
                                          },
                                          elevation: 0.0,
                                          child: Text("-",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery(gratis)",
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('E8FAF2'),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("?Una propina?"),
                    ),
                    Container(
                      decoration: orderList.order.tip == "1.00"
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1))
                          : null,
                      child: FloatingActionButton(
                        heroTag: 'btn3',
                        elevation: 0.0,
                        backgroundColor: HexColor('52D176'),
                        onPressed: () {
                          orderList.order.tip = '1.00';
                          setState(() {
                            orderList.order.originalPrice =
                                getCurrentOrderListPrice(orderList);
                          });
                        },
                        child: Center(
                          child: Text(
                            "S/1",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: orderList.order.tip == "2.00"
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1))
                          : null,
                      child: FloatingActionButton(
                        heroTag: 'btn4',
                        elevation: 0.0,
                        backgroundColor: HexColor('52D176'),
                        onPressed: () {
                          orderList.order.tip = '2.00';
                          setState(() {
                            orderList.order.originalPrice =
                                getCurrentOrderListPrice(orderList);
                          });
                        },
                        child: Center(
                          child: Text(
                            "S/2",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: orderList.order.tip == "3.00"
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1))
                          : null,
                      child: FloatingActionButton(
                        heroTag: 'btn5',
                        elevation: 0.0,
                        backgroundColor: HexColor('52D176'),
                        onPressed: () {
                          orderList.order.tip = '3.00';
                          setState(() {
                            orderList.order.originalPrice =
                                getCurrentOrderListPrice(orderList);
                          });
                        },
                        child: Center(
                          child: Text(
                            "S/3",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: orderList.order.tip == "4.00"
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1))
                          : null,
                      child: FloatingActionButton(
                        heroTag: 'btn6',
                        elevation: 0.0,
                        backgroundColor: HexColor('52D176'),
                        onPressed: () {
                          orderList.order.tip = '4.00';
                          setState(() {
                            orderList.order.originalPrice =
                                getCurrentOrderListPrice(orderList);
                          });
                        },
                        child: Center(
                          child: Text(
                            "S/4",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
