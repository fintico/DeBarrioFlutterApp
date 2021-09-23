import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/utilsFunctions.dart';
import 'package:debarrioapp/widgets/purchase/purchase_style.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

class PurchaseHeader extends StatelessWidget {
  //final SellerDish sellerDish;
  final SellerDetail sellerDish;
  const PurchaseHeader({Key key, this.sellerDish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                _imageBox(sellerDish.urlImage),
                _informationBox(sellerDish.restaurantName, purchaseBloc),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                _distanceBox(),
                _rateBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _imageBox(String urlImage) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, top: 28.0),
      child: cZeroStr(urlImage)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image(
                image: NetworkImage(
                    //dishProvider.list[index].image),
                    urlImage),
                height: 68.0,
                width: 68.0,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
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
                height: 68.0,
                width: 68.0,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  _informationBox(String restaurantName, PurchaseBloc purchaseBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 28.0),
          child: Text(
            restaurantName,
            style: titleHeaderStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 2.0),
          child: Text(
            purchaseBloc.addressDish,
            style: subtitleHeaderStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 11.0),
          child: Text(
            'Ver en Mapa',
            style: textMapHeaderStyle,
          ),
        ),
      ],
    );
  }

  _distanceBox() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: DBColors.GRAY_9,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 9.0, right: 5.0, top: 4.0, bottom: 4.0),
              child: Text(
                //widget.restaurant.reviews,
                "0.0 km",
                style: numberHeaderStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _rateBox() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: DBColors.YELLOW_LIGHT,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 3.0, top: 4.0, bottom: 4.0),
              child: Text(
                //widget.restaurant.reviews,
                "0.0",
                style: numberHeaderStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 4.0),
              child: StarIcon(
                height: 14,
                width: 16,
                color: DBColors.YELLOW_2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
