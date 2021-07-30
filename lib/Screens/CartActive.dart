/* import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calender_info_add_new_dish_to_publish.dart';
import 'fullproductinfo.dart';

class CartActive extends StatefulWidget {
  final List<PostedDish> currentDishes;

  const CartActive({Key key, this.currentDishes}) : super(key: key);

  @override
  _CartActiveState createState() => _CartActiveState();
}

class _CartActiveState extends State<CartActive> {
  PostedDish postedDish;

  @override
  Widget build(BuildContext context) {
    postedDish = Provider.of<PostedDish>(context);
    return ListView.builder(
      itemCount: widget.currentDishes.length,
      itemBuilder: (BuildContext context, int index) {
        PostedDish thisDish = widget.currentDishes[index];
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: Image(
                                fit: BoxFit.cover,
                                image: thisDish.dishPictureURI != null
                                    ? NetworkImage(thisDish.dishPictureURI)
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
                                      "${thisDish.name}",
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
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        "Porción(es):${thisDish.totalService}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => gotoSelectedPostedDish(index),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[600], width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[600], width: 1),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "DETALLE",
                                    style: TextStyle(color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CalenderFill(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  top: BorderSide(
                                      color: Colors.grey[600], width: 1),
                                )),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "VOLVER A VENDER",
                                    style: TextStyle(color: Colors.green[300]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.6,
                          //   margin: EdgeInsets.only(left: 16.0, top: 8.0),
                          //   child: Column(
                          //     children: [
                          //       Align(
                          //         alignment: AlignmentDirectional.topStart,
                          //         child: Text(
                          //           "${thisDish.name}",
                          //           textAlign: TextAlign.left,
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold, fontSize: 20),
                          //         ),
                          //       ),
                          //       Align(
                          //         alignment: AlignmentDirectional.topStart,
                          //         child: Row(
                          //           children: [
                          //             Container(
                          //               margin: EdgeInsets.only(top: 5.0),
                          //               child: Text(
                          //                 "Ganancias ",
                          //                 style: TextStyle(color: Colors.grey[400]),
                          //               ),
                          //             ), Container(
                          //               margin: EdgeInsets.only(top: 5.0),
                          //               child: Text(
                          //                 " S/ ${thisDish.originalPrice}",
                          //                 textAlign: TextAlign.start,
                          //
                          //                 style: TextStyle(color: Colors.grey[600],fontSize: 16,
                          //                     fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Align(
                          //         alignment: AlignmentDirectional.topStart,
                          //         child: Container(
                          //           width: MediaQuery.of(context).size.width * 0.3,
                          //           child: Text(
                          //             "Procion(es):${thisDish.totalService}",
                          //             textAlign: TextAlign.start,style:TextStyle(color: Colors.green),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: 3,
                          //   child:  Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Align(
                          //       alignment: AlignmentDirectional.centerEnd,
                          //       child: Icon(Icons.chevron_right,color: Colors.grey,),
                          //     ),
                          //   ),
                          // )
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

  void gotoSelectedPostedDish(int index) {
    postedDish.fromPostedDish(widget.currentDishes[index]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullInfoProd(),
      ),
    );
  }
}
 */
