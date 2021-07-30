import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
//import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/widgets/components/icons/filter.dart';
import 'package:debarrioapp/widgets/components/icons/search.dart';
import 'package:debarrioapp/widgets/home/home_filter_page.dart';
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
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
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
              //Expanded(child: _buildBody(context))
              Expanded(child: _buildCard(context, homeBloc.seller))
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeFilter(),
                      ),
                    );
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

  /* FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SellerService>(context).getDishesBySeller(),
      //future: dishes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          final List<SellerDish> sellers =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => SellerDish.fromJson(e))
                  .toList();
          return _buildCard(context, sellers);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  } */

  Widget _buildCard(BuildContext context, List<SellerDetail> sellers) {
    //print(sellers.length);
    return Container(
      color: DBColors.WHITE,
      //width: double.infinity,

      child: ListView.builder(
        itemCount: sellers == null ? 0 : sellers.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantCard(
            seller: sellers[index],
          );
        },
      ),
    );
  }
}
