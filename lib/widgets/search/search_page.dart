import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/customer_search.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/providers/search_provider.dart';
import 'package:debarrioapp/services/customer_service.dart';
import 'package:debarrioapp/services/dish_service.dart';
import 'package:debarrioapp/widgets/search/search_result.item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/icons/search.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'search_style.dart';
import 'search_history_item.dart';
import 'search_appbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final appBar = PreferredSize(
    child: SearchAppBar(),
    preferredSize: Size.fromHeight(100.0),
  );
  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    print(searchBloc.plate);
    return SafeArea(
      child: Scaffold(
        //appBar: appBar,
        body: Container(
          child: Column(
            children: [
              SearchAppBar(),
              Expanded(
                child: _buildBody(context, searchBloc.plate),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context, String plate) {
    return FutureBuilder(
      future: Provider.of<DishService>(context).getDishByName(plate),
      builder: (context, snapshot) {
        List<DishModel> dishes;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            /* final List<DishModel>  */ dishes =
                (json.decode(snapshot.data.bodyString) as List)
                    .map((e) => DishModel.fromJson(e))
                    .toList();
            return _buildSearch(context, dishes);
          }
          return _buildSearch(context, dishes);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildSearch(BuildContext context, List<DishModel> dishes) {
    print(dishes.length);
    return Container(
      color: DBColors.WHITE,
      width: double.infinity,
      child: dishes.length == 0
          ? _buildHistoryBody(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, bottom: 16.0),
                  child: Text(
                    'RESULTADOS',
                    style: itemSearchTitle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SearchResultItem(
                        dish: dishes[index],
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  FutureBuilder<Response> _buildHistoryBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CustomerService>(context).customerSearchById(28),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          final List<CustomerSearch> customerHistory =
              (json.decode(snapshot.data.bodyString) as List)
                  .map((e) => CustomerSearch.fromJson(e))
                  .toList();
          return _buildHistory(context, customerHistory);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildHistory(
      BuildContext context, List<CustomerSearch> customerHistory) {
    print(customerHistory.length);
    return Container(
      color: DBColors.WHITE,
      width: double.infinity,
      child: customerHistory.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NO HAY INFORMACIÓN RECIENTE.',
                  style: itemSearchTitle,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, bottom: 16.0),
                  child: Text(
                    'BÚSQUEDAS RECIENTES',
                    style: itemSearchTitle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: customerHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SearchHistoryItem(
                        customerSearch: customerHistory[index],
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
