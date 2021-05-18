import 'package:debarrioapp/Icons/my_flutter_app_icons.dart';
import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ModelClass/orderList.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'creditcard_info__add_new_credit_card.dart';

import 'CreditInfoMastercard.dart';
import 'agregormetodo_addCardScreen.dart';
import 'orderCompletion_done.dart';

class PayOptButton extends StatefulWidget {
  final bool fromOrder;

  const PayOptButton({Key key, this.fromOrder}) : super(key: key);

  @override
  _PayOptButtonState createState() => _PayOptButtonState();
}

class _PayOptButtonState extends State<PayOptButton> {
  User user;
  OrderList listOrder;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    listOrder = Provider.of<OrderList>(context);
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
                    "Metodo de pago",
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
          headerTitle: 'Métodos de pago',
          leftIconAction: () => Navigator.pop(context),
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        appBar: appBar,
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: user.cards.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        InkWell(
                          child: SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      MyFlutterApp.credit_card,
                                      size: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 32.0),
                                        child: Text(
                                          'Tarjeta de credito .... ${user.cards[index].cardNumber.substring(12)}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                  border: Border.all(
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () => {
                            if (widget.fromOrder)
                              {postOrder()}
                            else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AgregorMetodo(
                                            fromOrder: false,
                                            card: user.cards[index],
                                          )))
                          },
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                'Agregor metodo de pago',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AgregorMetodo(
                                            fromOrder: widget.fromOrder)))
                              },
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: HexColor('FBCC42'),
                          border: Border.all(
                            color: HexColor('FBCC42'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  postOrder() {
    DatabaseService database = DatabaseService();
    listOrder.order.orderDeliverLocation = user.address[0].addressLanLon;
    if (listOrder.myOrders.length == 1) {
      listOrder.order.dishName = listOrder.myOrders[0].name;
    }
    listOrder.order.dishPictureURL = listOrder.myOrders[0].dishPictureURI;
    int count = 0;
    listOrder.myOrders.forEach((element) {
      count += element.quantity;
    });
    listOrder.order.noOfDishes = count;
    database.setOrderedData(listOrder.order);
    Order currentOrder = listOrder.order;
    for (OrderedDish dish in listOrder.myOrders) {
      database.setOrderedDishData(dish);
    }
    listOrder.myOrders = [];
    listOrder.order = null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => OrderConpletion(
                  order: currentOrder,
                )));
  }
}
