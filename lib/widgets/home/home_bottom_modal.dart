import 'package:debarrioapp/widgets/components/icons/filter.dart';
import 'package:debarrioapp/widgets/components/icons/search.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'home_style.dart';
import 'home_restaurant_card.dart';

class BottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.19,
      minChildSize: 0.19,
      maxChildSize: 0.7,
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
              Expanded(
                child: ListaItems(scrollController),
              )
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
                        onPressed: () => {print('search')},
                      ),
                      border: OutlineInputBorder(),
                      hintText: "¿Qué se te antoja hoy?",
                      hintStyle: textHintStyle,
                      contentPadding:
                          EdgeInsets.only(left: 12.0, top: 14.0, bottom: 14.0),
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
}

class ListaItems extends StatelessWidget {
  final ScrollController scrollController;

  List<int> items = new List(1);

  ListaItems(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: this.scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) => RestaurantCard()

        //ListTile(
        //title: Text('Item: $index'),
        //),
        );
  }
}
