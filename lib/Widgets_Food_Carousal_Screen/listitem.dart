import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:flutter/material.dart';

import '../utilsFunctions.dart';

class ItemList extends StatefulWidget {
  final User currentRestaurant;

  const ItemList({Key key, this.currentRestaurant}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[400])),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.15,
              child: Image(
                fit: BoxFit.cover,
                image: cZeroStr(widget.currentRestaurant.pictureUri)
                    ? NetworkImage(widget.currentRestaurant.pictureUri)
                    : AssetImage('assets/images/listitem.png'),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  title: Text(widget.currentRestaurant.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle:
                      Text(widget.currentRestaurant.address[0].addressString),
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300],
                        ),
                        child: Center(
                            child: Text(
                                "${widget.currentRestaurant.distance} km")),
                      ),
                      Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.currentRestaurant.reviews} "),
                              Icon(
                                Icons.star_border,
                                size: 15,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
