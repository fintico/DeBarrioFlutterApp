import 'dart:developer';

import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/food_carousel.dart';
import 'package:debarrioapp/Screens/map_screen.dart';
import 'package:debarrioapp/utilsFunctions.dart';

import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/widgets/components/icons/comment.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';

import 'package:flutter/material.dart';

class FoodItemList extends StatefulWidget {
  //final User restaurant;
  final Customer customer;
  //final List<PostedDish> postedDishes;

  const FoodItemList({Key key, this.customer}) : super(key: key);

  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  TextStyle titleCardStyle = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );
  TextStyle subtitleCardStyle = DBStyle.getStyle(
    DBStyle.GRAY_2,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );

  TextStyle numberCardStyle = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );

  @override
  Widget build(BuildContext context) {
    //inspect(widget.restaurant);
    print('print');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.17,
        child: InkWell(
          /* onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantCarouselSlider(
                postedDishes: widget.postedDishes,
                selectedRestaurant: widget.restaurant,
              ),
            ),
          ), */
          child: Card(
            color: DBColors.WHITE,
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.11,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: DBColors.GRAY_6,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Image(
                          image: AssetImage("assets/images/listitem.png"),
                          /* image: cZeroStr(widget.restaurant.pictureUri)
                              ? NetworkImage(widget.restaurant.pictureUri)
                              : AssetImage("assets/images/listitem.png"), */
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 12.0),
                              child: Text(
                                widget.customer.name,
                                //'La Buena Sazón',
                                style: titleCardStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 2.0),
                              child: Text(
                                //widget.restaurant.restaurantName,
                                'La Buena Sazón',
                                style: subtitleCardStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Row(
                                  /*mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween, */
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: DBColors.YELLOW_LIGHT,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 3.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: Text(
                                              //widget.restaurant.reviews,
                                              "5.0",
                                              style: numberCardStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: StarIcon(
                                              height: 14,
                                              width: 16,
                                              color: DBColors.YELLOW_2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: DBColors.BLUE_LIGHT_4,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 3.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: Text(
                                              "80",
                                              style: numberCardStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: CommentIcon(
                                                height: 14,
                                                width: 16,
                                                color: DBColors.BLUE_LIGHT_3),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: DBColors.GRAY_9,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 3.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: Text(
                                              "0.8",
                                              style: numberCardStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0,
                                                top: 4.0,
                                                bottom: 4.0),
                                            child: Text(
                                              "km",
                                              style: numberCardStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                          "${widget.restaurant.distance / 1000} km"),
                                    ) */
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
