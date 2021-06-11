import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
//import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/widgets/components/icons/filter.dart';
import 'package:debarrioapp/widgets/components/icons/search.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'home_style.dart';
import 'home_restaurant_card.dart';

class BottomModal extends StatefulWidget {
  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal>
/* with AutomaticKeepAliveClientMixin */ {
  /* var dishes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dishes = Provider.of<DishService>(context).getDishList();
  } */

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    //_getDish(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.98,
      builder: (context, scrollController) {
        return Container(
          child: Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              SingleChildScrollView(
                controller: scrollController,
                child: searchDish(),
              ),
              //_buildBody(context, scrollController),
              Expanded(child: _buildBody(context))
              /* Expanded(
                child: ListaItems(scrollController),
              ) */
            ],
          ),
          decoration: BoxDecoration(
            color: DBColors.GRAY_8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
        );
      },
    );
  }

  Widget searchDish() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            height: 4.0,
            width: 48.0,
            decoration: BoxDecoration(
              color: DBColors.GRAY_10,
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, top: 20.0, bottom: 24.0),
                  child: InkWell(
                    onTap: () {
                      Routes.sailor.navigate(
                        Routes.SEARCH_SCREEN,
                        navigationType: NavigationType.pushReplace,
                      );
                    },
                    child: TextFormField(
                      //controller: _textLocation,
                      readOnly: true,
                      onFieldSubmitted: (value) {},
                      style: textFieldStyle,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: SearchIcon(
                            height: 24.0,
                            width: 24.0,
                            color: DBColors.GRAY_2,
                          ),
                          onPressed: () => {
                            Routes.sailor.navigate(
                              Routes.SEARCH_SCREEN,
                              navigationType: NavigationType.pushReplace,
                            )
                          },
                        ),
                        border: OutlineInputBorder(),
                        hintText: "¿Qué se te antoja hoy?",
                        hintStyle: textHintStyle,
                        contentPadding: EdgeInsets.only(
                            left: 12.0, top: 14.0, bottom: 14.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(right: 16.0, top: 32.0, bottom: 36.0),
                child: InkWell(
                  onTap: () {
                    print('filter');
                  },
                  child: FilterIcon(
                    type: 0,
                    height: 24.0,
                    width: 24.0,
                    color: DBColors.GRAY_2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DishService>(context).getDishList(),
      //future: dishes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          final List<DishModel> dishes =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => DishModel.fromJson(e))
                  .toList();
          return _buildCard(context, dishes);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCard(BuildContext context, List<DishModel> dishes) {
    print(dishes.length);
    return Container(
      color: DBColors.WHITE,
      //width: double.infinity,

      child: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantCard(
            dish: dishes[index],
          );
        },
      ),
    );
  }

  /* @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; */
}

class ListaItems extends StatelessWidget {
  final ScrollController scrollController;

  List<int> items = new List(1);

  ListaItems(this.scrollController);

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context);
    hitApi(context, dishProvider);
    return ListView.builder(
      controller: this.scrollController,
      itemCount: dishProvider.list.length,
      //itemBuilder: (context, index) => RestaurantCard(index: index),
    );
    //final dishBloc = Provider.of<DishModel>(context);
    /* return FutureBuilder<Response>(
      future: Provider.of<DishService>(context).getDishList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('date incoming');
          /* final List<dynamic> dataItems =
              json.decode(utf8.decode(snapshot.data.bodyBytes));
          inspect(dataItems); */
          //DishModel dishModel = DishModel.fromJson(dataItems);
          //print(dishModel);
          //inspect(dishModel);
          //print(snapshot.connectionState);
          //inspect(snapshot);
          //List<DishModel> items = [];
          //onDishData(snapshot, items);
          //return Text('data');
          return ListView.builder(
            controller: this.scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) => RestaurantCard(),
          );
        } else {
          print('nel');
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ); */
    /* return ListView.builder(
        controller: this.scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) => RestaurantCard()

        //ListTile(
        //title: Text('Item: $index'),
        //),
        ); */
  }

  Future hitApi(BuildContext context, DishProvider dishProvider) async {
    try {
      Response<dynamic> res =
          await Provider.of<DishService>(context, listen: false).getDishList();
      //print(res.bodyString);
      //List<dynamic> jsonBody = json.decode(res.bodyString);
      List<DishModel> dishModel = (json.decode(res.bodyString) as List)
          .map((e) => DishModel.fromJson(e))
          .toList();

      dishProvider.setList(dishModel);
      //inspect(dishModel);
      //inspect(dishModel[0]);
      //inspect(DishModel());
      //DishModel dishModel;
      //print(dishModel.toJson());

      //print(dishModel);
      //inspect(dishModel);
    } catch (e) {
      print(e);
    }
  }

  void onDishData(AsyncSnapshot<Response> snapshot, List<DishModel> items) {
    try {
      //final List<dynamic> dataItems = json.decode(utf8.decode(snapshot.data.bodyBytes));
      final Map dataItems = json.decode(snapshot.data.bodyString);

      print('dataItems');

      //inspect(dataItems);
      /* for (var data in dataItems) {
        items.add(DishModel(
            id: data['id'],
            dishName: data['dish_name'],
            image: data['image'],
            stock: data['stock'],
            deliveryDate: data['delivery_date'],
            deliveryTimeFrom: data['delivery_time_from'],
            deliveryTimeTo: data['delivery_time_to'],
            priceDelivery: data['price_delivery'],
            pricePickup: data['price_pickup'],
            isActive: data['is_active'],
            seller: data['seller'],
            dishCategory: data['dish_category'],
            additional: data['additional']));
      }
      print('aqui');
      inspect(items);
      inspect(items[0]); */
    } catch (e) {
      print(e);
    }
  }
}
