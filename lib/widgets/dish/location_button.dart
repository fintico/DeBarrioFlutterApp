import 'dart:developer';

import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/providers/location_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/pointer.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/components/icons/radio_inactive.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

class LocationButton extends StatelessWidget {
  final SellerAddress? sellerAddress;
  const LocationButton({Key? key, this.sellerAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final locationProvider =
        Provider.of<LocationProvider>(context, listen: false); */
    return InkWell(
      onTap: () async {
        inspect(sellerAddress!.address);
        Navigator.pop(context);
        //_setAddres();
      },
      child: Container(
        width: double.infinity,
        //height: 64.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          //color: DBColors.WHITE,
          //color: DBColors.WHITE,
        ),
        child: Center(
          child: Container(
              //padding: EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 34.0, top: 34.0, bottom: 34.0),
                    child: PointerIcon(
                      height: 20.0,
                      width: 20.0,
                      color: DBColors.GRAY_2,
                    ),
                  ),
                  Container(
                      width: screenWidth(context, dividedBy: 1.5),
                      /* padding: const EdgeInsets.only(
                          left: 14.0, top: 20.0, bottom: 44.0), */
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 14.0, top: 20.0),
                            child: Text(
                              sellerAddress!.address!.address!,
                              textAlign: TextAlign.left,
                              style: DBStyles.getStyle(
                                DBStyles.BLACK,
                                DBStyles.FONT_SYZE_M,
                                DBStyles.FONT_HEIGHT_M,
                                0.0,
                                DBStyles.FONT_WEIGHT_SEMI_BOLD,
                              ),
                            ),
                          ),
                          Container(
                            //color: Colors.grey,
                            padding:
                                const EdgeInsets.only(left: 14.0, bottom: 20.0),
                            child: Text(
                              sellerAddress!.address!.addressDescription ?? '-',
                              textAlign: TextAlign.left,
                              style: DBStyles.getStyle(
                                DBStyles.GRAY_2,
                                DBStyles.FONT_SYZE_S,
                                DBStyles.FONT_HEIGHT_S,
                                0.0,
                                DBStyles.FONT_WEIGHT_REGULAR,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 34.0, right: 34.0, bottom: 34.0),
                    child: iconState(),
                    /* child: RadioActiveIcon(
                      height: 20.0,
                      width: 20.0,
                    ), */
                  )
                ],
              ),
              Divider(
                color: DBColors.GRAY_12,
                indent: 28.0,
                endIndent: 28.0,
                thickness: 1.0,
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget iconState() {
    return sellerAddress!.isActive!
        ? RadioActiveIcon(
            height: 20.0,
            width: 20.0,
          )
        : RadioInactiveIcon(
            height: 20.0,
            width: 20.0,
          );
  }

  _setAddres() async {
    /* Routes.sailor.navigate(
      Routes.DISH_PUBLISH_SCREEN,
      navigationType: NavigationType.push,
      //params: {'dishModel': dishModel, 'address': sellerAddress.address},
    ); */
  }
}
