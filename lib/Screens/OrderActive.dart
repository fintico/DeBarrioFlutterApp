import 'package:da_brello_ui/ModelClass/OrderModel.dart';
import 'package:flutter/material.dart';

class CartOrderActive extends StatefulWidget {
  final List<Order> currentOrders;

  const CartOrderActive({Key key, this.currentOrders}) : super(key: key);

  @override
  _CartOrderActiveState createState() => _CartOrderActiveState();
}

class _CartOrderActiveState extends State<CartOrderActive> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.currentOrders.length,
      itemBuilder: (BuildContext context, int index) {
        Order thisDish = widget.currentOrders[index];
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.height,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                shadowColor: Colors.black,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            child: Image(
                              fit: BoxFit.cover,
                              image: thisDish.dishPictureURL != null
                                  ? NetworkImage(thisDish.dishPictureURL)
                                  : AssetImage(
                                  'assets/images/carouselfirst.png'),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: EdgeInsets.only(left: 16.0, top: 8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    "${thisDish.dishName??thisDish.id.substring(thisDish.id.length-12)}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "Ganancias ",
                                          style: TextStyle(
                                              color: Colors.grey[400]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          " S/ ${thisDish.originalPrice}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      "Procion(es):${thisDish.noOfDishes}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
