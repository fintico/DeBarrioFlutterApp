import 'package:debarrioapp/providers/order_provider.dart';
import 'package:debarrioapp/widgets/components/icons/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import '../../../../utilsFunctions.dart';
import '../order_style.dart';

class OrderDetailFinishHeader extends StatelessWidget {
  const OrderDetailFinishHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderBloc = Provider.of<OrderBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                _imageBox(orderBloc.orderDetail!.dish!.seller!.urlImage!),
                _informationBox(
                    orderBloc.orderDetail!.dish!.seller!.restaurantName!),
              ],
            ),
            _rateBox(
              orderBloc.orderDetail!.dish!.seller!.rating!.rated != null
                  ? orderBloc.orderDetail!.dish!.seller!.rating!.rated!
                      .toStringAsFixed(1)
                  : '0.0',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 32.0),
              child: Text(
                'ORDEN #0${orderBloc.orderDetail!.order!.id}',
                style: titleOrderHeaderStyle,
              ),
            ),
            _stateOffBox(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 3.0, bottom: 15.0),
          child: Text(
            'Entregada ${dateOrderedTimeString(orderBloc.orderDetail!.order!)}',
            style: subtitleOrderHeaderStyle,
          ),
        ),
        Divider(
          color: DBColors.BLUE_LIGHT_5,
          thickness: 1.0,
          indent: 28.0,
          endIndent: 28.0,
        ),
      ],
    );
  }

  _imageBox(String urlImage) {
    return Container(
      padding: const EdgeInsets.only(left: 28.0, top: 32.0),
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
                height: 68.0,
                width: 68.0,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  _informationBox(String restaurantName /* , PurchaseBloc purchaseBloc */) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 40.0),
          child: Text(
            restaurantName,
            style: titleHeaderStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            'Ir a la tienda',
            style: textStoreHeaderStyle,
          ),
        ),
      ],
    );
  }

  _rateBox(String rating) {
    return Padding(
      padding: const EdgeInsets.only(right: 28.0, top: 42.0),
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
                "$rating",
                style: numberHeaderStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 5.0),
              child: StarIcon(
                height: 15,
                width: 16,
                color: DBColors.YELLOW_2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _stateOffBox() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 28.0, top: 32.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          width: 86.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: DBColors.GRAY_15,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 6.0,
                width: 6.0,
                decoration: BoxDecoration(
                  color: DBColors.GRAY_2,
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              Text(
                'FINALIZADA',
                style: stateOFFStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
