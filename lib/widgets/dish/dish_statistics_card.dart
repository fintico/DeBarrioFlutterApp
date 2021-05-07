import 'package:debarrioapp/widgets/components/icons/comment.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';

import 'dish_style.dart';

class DishStatisticsCard extends StatefulWidget {
  DishStatisticsCard({Key key}) : super(key: key);

  @override
  _DishStatisticsCardState createState() => _DishStatisticsCardState();
}

class _DishStatisticsCardState extends State<DishStatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          width: MediaQuery.of(context).size.width,
          //color: DBColors.GRAY_8,
          //height: screenHeight(context, dividedBy: 6.5),
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
              //elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: //Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //children: [
                  /* Padding(
                padding: const EdgeInsets.all(12.0),
                child: */
                  Row(
                children: [
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.2,
                    //height: MediaQuery.of(context).size.height * 0.11,
/*                 decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ), */
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 30.0, bottom: 30.0),
                    /* decoration: BoxDecoration(
                  border: Border.all(
                    color: DBColors.GRAY_6,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ), */
                    /* child: SvgPicture.asset(
                  "assets/images/ras_logo.svg",
                  fit: BoxFit.cover,
                  height: 68.0,
                  width: 68.0,
                ), */
                    /* child: Image(
                      image: AssetImage("assets/images/listitem.png"),
                      fit: BoxFit.cover,
                      height: 68.0,
                      width: 68.0,
                    ), */
                    child: SvgPicture.asset(
                      'assets/images/graph_bar.svg',
                      height: 44.0,
                      width: 44.0,
                    ),
                    /* image: cZeroStr(widget.restaurant.pictureUri)
                              ? NetworkImage(widget.restaurant.pictureUri)
                              : AssetImage("assets/images/listitem.png"), */
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.6,
                    //height: screenHeight(context, dividedBy: 2.0),
                    /* padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0), */
                    /* decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ), */
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 18.0),
                              child: Text(
                                '0.0',
                                style: titleCardStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 18.0),
                              child: Text(
                                'Ventas',
                                style: subtitleCardStyle,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 4.0),
                              child: Text(
                                '0.0',
                                style: titleCardStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                'Visitas',
                                style: subtitleCardStyle,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 4.0, bottom: 18.0),
                              child: Text(
                                'S/ 0.00',
                                style: titleCardStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 18.0),
                              child: Text(
                                'Ganancias',
                                style: subtitleCardStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //),
              //],
              //),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
