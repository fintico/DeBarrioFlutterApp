import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/providers/dish_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/icons/comment.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';
import 'package:debarrioapp/widgets/purchase/purchase_home_page.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../utilsFunctions.dart';
import 'home_style.dart';

class RestaurantCard extends StatefulWidget {
  //final DishModel dish;
  //final SellerDish seller;
  final SellerDetail? seller;
  const RestaurantCard({Key? key, this.seller}) : super(key: key);

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    //final dishProvider = Provider.of<DishProvider>(context);
    //print('card');
    //print(dishBloc.deliveryDate);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          width: MediaQuery.of(context).size.width,
          color: DBColors.GRAY_8,
          height: screenHeight(context, dividedBy: 7.0),
          child: InkWell(
            onTap: () {
              Routes.sailor.navigate(
                Routes.PURCHASE_HOME_SCREEN,
                navigationType: NavigationType.pushReplace,
                params: {
                  'sellerDish': widget.seller,
                },
              );
              print(widget.seller!.userId);
              print('card');
            },
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
                        left: 12.0, top: 12.0, bottom: 16.0),

                    child: cZeroStr(widget.seller!.urlImage)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image(
                              image: NetworkImage(
                                  //dishProvider.list[index].image),
                                  widget.seller!.urlImage),
                              height: 56.0,
                              width: 56.0,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: SvgPicture.asset(
                              'assets/images/empty.svg',
                              height: 46.0,
                              width: 46.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.6,
                    //height: MediaQuery.of(context).size.height * 0.12,
                    /* padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0), */
                    /* decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ), */
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                          child: Text(
                            //widget.customer.name,
                            widget.seller!.restaurantName!,
                            style: titleCardStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                          child: Text(
                            widget.seller!.dishes!.length >= 1
                                ? widget.seller!.dishes![0].dishCategory!
                                    .dishCategoryDescription!
                                : '-',
                            style: subtitleCardStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8.0, bottom: 4.0),
                          child: Container(
                            //width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              /*mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween, */
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: DBColors.YELLOW_LIGHT,
                                    borderRadius: BorderRadius.circular(4.0),
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
                                          "0.0",
                                          style: numberCardStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 4.0, bottom: 4.0),
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
                                    borderRadius: BorderRadius.circular(4.0),
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
                                          "00",
                                          style: numberCardStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 4.0, bottom: 4.0),
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
                                    borderRadius: BorderRadius.circular(4.0),
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
                                          "0.0",
                                          style: numberCardStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 4.0, bottom: 4.0),
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
