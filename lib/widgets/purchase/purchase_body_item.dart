import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:debarrioapp/models/seller_detail.dart';
import 'package:debarrioapp/models/seller_dish.dart';
import 'package:debarrioapp/providers/purchase_provider.dart';
import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:debarrioapp/widgets/components/icons/watch.dart';
import 'package:debarrioapp/widgets/purchase/purchase_add_notify.dart';
import 'package:debarrioapp/widgets/purchase/purchase_availability_item.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utilsFunctions.dart';
import 'purchase_style.dart';

class PurchaseBody extends StatefulWidget {
  //final SellerDish sellerDish;
  final SellerDetail sellerDish;
  PurchaseBody({Key key, this.sellerDish}) : super(key: key);

  @override
  _PurchaseBodyState createState() => _PurchaseBodyState();
}

class _PurchaseBodyState extends State<PurchaseBody> {
  int _current = 0;
  int counter = 1;
  bool checkAdd = false;
  int delivery = 1;

  @override
  Widget build(BuildContext context) {
    //ScrollController _scrollController;
    final purchaseBloc = Provider.of<PurchaseBloc>(context);
    Future.delayed(Duration.zero, () async {
      purchaseBloc
          .onAddress(widget.sellerDish.dishes[_current].address.address);
      purchaseBloc.onDishName(widget.sellerDish.dishes[_current].dishName);
      purchaseBloc.onDishId(widget.sellerDish.dishes[_current].id);
      purchaseBloc.onRestaurant(widget.sellerDish.restaurantName);
      purchaseBloc.onDishImage(widget.sellerDish.dishes[_current].image);
      if (delivery == 1) {
        purchaseBloc.onPriceDeliveryType(
            widget.sellerDish.dishes[_current].priceDelivery);
        purchaseBloc.onDelivery();
        //print(purchaseBloc.delivery);
      } else {
        purchaseBloc.onPriceDeliveryType(
            widget.sellerDish.dishes[_current].pricePickup);
        purchaseBloc.onPickup();
        //print(purchaseBloc.pickup);
      }
      if (widget.sellerDish.dishes[_current].additional != null) {
        if (checkAdd == true) {
          purchaseBloc.onTotalPrice(purchaseBloc.priceDeliveryType +
              (widget.sellerDish.dishes[_current].additional.isFree
                  ? 0
                  : widget.sellerDish.dishes[_current].additional.price));
        } else {
          purchaseBloc.onTotalPrice(purchaseBloc.priceDeliveryType);
        }
      } else {
        purchaseBloc.onTotalPrice(purchaseBloc.priceDeliveryType);
      }
    });

    return SingleChildScrollView(
        child: Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _carouselBody(purchaseBloc),
            _dotsBody(),
            _detailBody(purchaseBloc),
          ],
        ),
        purchaseBloc.isCreated
            ? Positioned(
                bottom: 10.0,
                right: 5.0,
                left: 5.0,
                child: PurchaseAddNotify(
                  isCreated: true,
                ),
              )
            : SizedBox()
      ],
    )

        /* Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _carouselBody(purchaseBloc),
          _dotsBody(),
          _detailBody(purchaseBloc),
        ],
      ), */
        );
  }

  _carouselBody(PurchaseBloc purchaseBloc) {
    return Container(
      padding: const EdgeInsets.only(top: 13.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180.0,
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
              counter = 0;
            });
          },
        ),
        items: widget.sellerDish.dishes.map((item) {
          int index = widget.sellerDish.dishes.indexOf(item);
          return Container(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                cZeroStr(item.image)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image(
                          image: NetworkImage(item.image),
                          //height: 56.0,
                          width: screenWidth(context, dividedBy: 1.2),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                          //height: 46.0,
                          width: screenWidth(context, dividedBy: 1.5),
                          fit: BoxFit.cover,
                        ),
                      ),

                /* Center(
                  child:
                      Image.network(item.image, fit: BoxFit.cover, width: 1200),
                ), */
                _current == index && purchaseBloc.counter != 1
                    ? Positioned(
                        top: 1,
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: DBColors.GREEN,
                          ),
                          child: Center(
                              child: Text(
                            '${purchaseBloc.counter}',
                            style: numberCounterStyle,
                          )),
                        ),
                      )
                    : Text(' '),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  _dotsBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.sellerDish.dishes.map((i) {
          int index = widget.sellerDish.dishes.indexOf(i);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? DBColors.GRAY_2 : DBColors.GRAY_3,
            ),
          );
        }).toList(),
      ),
    );
  }

  _detailBody(PurchaseBloc purchaseBloc) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 20.0),
            child: Text(
              widget.sellerDish.dishes[_current].dishName,
              style: dishBodyStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 4.0),
            child: Text(
              delivery == 1
                  ? 'S/ ${widget.sellerDish.dishes[_current].priceDelivery.toStringAsFixed(2)}'
                  : 'S/ ${widget.sellerDish.dishes[_current].pricePickup.toStringAsFixed(2)}',
              style: priceBodyStyle,
            ),
          ),
          _deliveryType(purchaseBloc),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 24.0),
                        child: Text(
                          'ENTREGA',
                          style: titleBoxBodyStyle,
                        ),
                      ),
                      _timeBox(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 67.0, top: 24.0),
                        child: Text(
                          'DISPONIBILIDAD',
                          style: titleBoxBodyStyle,
                        ),
                      ),
                      _availabilityBox(purchaseBloc),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.sellerDish.dishes[_current].additional != null
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 20.0),
                        child: Text(
                          'ADICIONALES',
                          style: titleBoxBodyStyle,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        //controller: _scrollController,
                        itemCount: 1,
                        itemBuilder: (_, index) {
                          return _additionalBox();
                        },
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 1.0,
                )
        ],
      ),
    );
  }

  _deliveryType(PurchaseBloc purchaseBloc) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Radio(
                  onChanged: (value) => {
                    setState(() {
                      delivery = value;
                      print(delivery);
                    })
                  },
                  value: 1,
                  groupValue: delivery,
                  activeColor: Colors.green,
                ),
                Text(
                  'Delivery',
                  style: radioBodyStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Radio(
                  onChanged: (value) => {
                    setState(() {
                      delivery = value;
                      print(delivery);
                    })
                  },
                  value: 0,
                  groupValue: delivery,
                  activeColor: Colors.green,
                ),
                Text(
                  'Recojo',
                  style: radioBodyStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _timeBox() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 12.0),
            child: WatchIcon(height: 24.0, width: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              '${timeDetail24H(widget.sellerDish.dishes[_current])}',
              style: timeBodyStyle,
            ),
          ),
        ],
      ),
    );
  }

  _availabilityBox(PurchaseBloc purchaseBloc) {
    return Padding(
      padding: const EdgeInsets.only(right: 67.0, top: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: DBColors.GREEN,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: InkWell(
          onTap: () {
            print('Hoy');
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              builder: (context) {
                return PurchaseAvailability();
              },
            );
          },
          borderRadius: BorderRadius.circular(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                child: Text(
                  purchaseBloc.shortDate ?? 'Hoy',
                  style: avaibalityBodyStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, top: 2.0, bottom: 2.0, right: 16.0),
                child: AngleDownIcon(
                    height: 20.0, width: 20.0, color: DBColors.WHITE),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _additionalBox() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 12.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: DBColors.GREEN,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  value: checkAdd,
                  onChanged: (value) {
                    setState(() {
                      checkAdd = value;
                      print(checkAdd);
                    });
                  },
                ),
                Text(
                  widget.sellerDish.dishes[_current].additional
                      .additionalDescription,
                  style: additionalTextBodyStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, top: 12.0),
            child: Text(
              widget.sellerDish.dishes[_current].additional.isFree
                  ? 'Gratis'
                  : 'S/ ${widget.sellerDish.dishes[_current].additional.price.toString()}',
              style: priceAdditionalTextBodyStyle,
            ),
          ),
        ],
      ),
    );
  }
}
