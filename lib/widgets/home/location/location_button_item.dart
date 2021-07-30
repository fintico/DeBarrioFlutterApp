import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/pointer.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/components/icons/radio_inactive.dart';

import 'package:flutter/material.dart';
import 'location_style.dart';

class LocationButtonItem extends StatelessWidget {
  const LocationButtonItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        /* inspect(sellerAddress.address);
        inspect(dishModel);
        await setAddres(context);
        Routes.sailor.navigate(Routes.DISH_REPUBLISH_SCREEN,
            navigationType: NavigationType.pushReplace,
            params: {'dishModel': dishModel, 'address': sellerAddress.address}); */
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
                              'sellerAddress.address.address',
                              textAlign: TextAlign.left,
                              style: titleLocationItemStyle,
                            ),
                          ),
                          Container(
                            //color: Colors.grey,
                            padding:
                                const EdgeInsets.only(left: 14.0, bottom: 20.0),
                            child: Text(
                              /* sellerAddress.address.addressDescription ?? */ '-',
                              textAlign: TextAlign.left,
                              style: descriptionLocationItemStyle,
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
    return /* sellerAddress.isActive */ false
        ? RadioActiveIcon(
            height: 20.0,
            width: 20.0,
          )
        : RadioInactiveIcon(
            height: 20.0,
            width: 20.0,
          );
  }
}
