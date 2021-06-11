import 'package:debarrioapp/providers/search_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/icons/search.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import 'search_style.dart';

class SearchAppBar extends StatefulWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController _dishNameController = TextEditingController();
  String dishName = '';

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);
    return Container(
      color: DBColors.WHITE,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 28.0, top: 8.0, bottom: 32.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    dishName = value;
                    if (value.length >= 3) {
                      searchBloc.onChangePlate(value);
                    } else {
                      searchBloc.onChangePlate('0');
                    }
                  });
                },
                style: searchInput,
                controller: _dishNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: '¿Qué se te antoja hoy?',
                  hintStyle: hintSearchInput,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, right: 12.0, bottom: 12.0),
                    child: _dishNameController.text.length < 1
                        ? InkWell(
                            onTap: () {
                              print('buscar');
                            },
                            child: SearchIcon(
                              height: 24.0,
                              width: 24.0,
                              color: DBColors.GREEN,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _dishNameController.clear();
                              setState(() {
                                //dishName = 'null';
                                searchBloc.onChangePlate('0');
                              });
                            },
                            child: CrossIcon(
                              height: 24.0,
                              width: 24.0,
                              color: DBColors.GREEN,
                            ),
                          ),
                  ),
                  fillColor: DBColors.GREEN,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(
                      color: DBColors.GREEN,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.only(left: 12.0, top: 14.0, bottom: 12.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 28.0, top: 24.0, bottom: 48.0),
            child: InkWell(
              onTap: () {
                print('cancelar');
                Routes.sailor.navigate(
                  Routes.HOME_SCREEN,
                  navigationType: NavigationType.pushReplace,
                );
              },
              child: Text(
                'CANCELAR',
                style: cancelSearchTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
