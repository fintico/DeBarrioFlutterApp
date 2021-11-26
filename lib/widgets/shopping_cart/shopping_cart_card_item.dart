import 'package:debarrioapp/models/order_detail.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/widgets/components/icons/minus.dart';
import 'package:debarrioapp/widgets/components/icons/plus.dart';
import 'package:debarrioapp/widgets/components/icons/trash.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utilsFunctions.dart';
import 'shopping_cart_style.dart';

class ShoppingCartCard extends StatelessWidget {
  //final OrderDetail orderDetail;
  final int? index;
  const ShoppingCartCard({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    return /* Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      child: */
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          color: DBColors.GRAY_6,
          thickness: 1.0,
          indent: 24.0,
          endIndent: 24.0,
          height: 1.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, top: 20.0, bottom: 21.0),
                  child: cZeroStr(purchaseBloc.orderDetails[index!].dish!.image)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image(
                            image: NetworkImage(
                                //dishProvider.list[index].image),
                                purchaseBloc.orderDetails[index!].dish!.image!),
                            height: 56.0,
                            width: 56.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                            height: 46.0,
                            width: 46.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                      child: Text(
                        //purchaseBloc.dishName,
                        purchaseBloc.orderDetails[index!].dish!.dishName!,
                        style: titleDishHeaderStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 4.0, bottom: 21.0),
                      child: Text(
                        'S/ ${purchaseBloc.orderDetails[index!].order!.totalPrice!.toStringAsFixed(2)}',
                        style: titlePriceHeaderStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 24.0, top: 32.0, bottom: 37.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        print('menos');
                        purchaseBloc.onSubtractItem(index!);
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: MinusIcon()),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(
                      purchaseBloc.orderDetails[index!].order!.portion
                          .toString(),
                      //purchaseBloc.counter.toString(),
                      style: numberCardStyle,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        print('mas');
                        purchaseBloc.onAddItem(index!);
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: PlusIcon()),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: DBColors.GRAY_6,
          thickness: 1.0,
          indent: 24.0,
          endIndent: 24.0,
          height: 1.0,
        ),
      ],
      //),
      //),
      /* secondaryActions: <Widget>[
        IconSlideAction(
          color: DBColors.RED,
          iconWidget:
              TrashIcon(height: 24.0, width: 24.0, color: DBColors.WHITE),
          onTap: () => {print('elimiar item')},
        ),
      ], */
    );
  }
}
