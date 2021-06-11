import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:debarrioapp/models/address.dart';
import 'package:debarrioapp/models/dishModel.dart';
import 'package:debarrioapp/models/seller_address.dart';
import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/widgets/dish/location_button.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/services/location_service.dart';
import 'package:debarrioapp/models/location_model.dart';
import 'package:debarrioapp/widgets/components/icons/search.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_five.dart';
import 'package:debarrioapp/providers/location_provider.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'dish_style.dart';

class DishLocation extends StatelessWidget {
  final DishModel dishModel;
  const DishLocation({Key key, this.dishModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*     final locationProvider = Provider.of<LocationProvider>(context); */
    final appBar = PreferredSize(
      child: AppBarOptionFive(
        leftIconAction: () => Navigator.pop(context),
        headerTitle: 'Dirección actual',
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 28.0, left: 28.0, top: 32.0),
                child: Text(
                  'Agrega o elige una dirección',
                  style: titleLocationStyle,
                ),
              ),
              searchLocation(),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 16.0, bottom: 16.0),
                        child: SvgPicture.asset(
                          "assets/icons/location.svg",
                          height: 32.0,
                          width: 32.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 20.0, bottom: 20.0),
                        child: Text(
                          'Ubicación actual',
                          style: titleLocationButtonStyle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: DBColors.GRAY_12,
                indent: 28.0,
                endIndent: 28.0,
                thickness: 1.0,
              ),
              Expanded(
                child: _buildBody(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  searchLocation() {
    return Container(
      padding: const EdgeInsets.only(right: 28.0, left: 28.0, top: 22.0),
      child: TextFormField(
        //controller: _textLocation,
        readOnly: true,
        onFieldSubmitted: (value) {},
        style: textFieldLocationStyle,
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
          hintText: "Ingresa una nueva dirección",
          hintStyle: textHintLocationStyle,
          contentPadding: EdgeInsets.only(left: 12.0, top: 14.0, bottom: 14.0),
        ),
      ),
    );
  }

  Future getLocation(
      BuildContext context, LocationProvider locationProvider) async {
    try {
      //print('hola');
      Response<dynamic> res =
          await Provider.of<LocationService>(context, listen: false)
              .getLocationList();
      //print(res.bodyString);
      //List<dynamic> jsonBody = json.decode(res.bodyString);
      List<LocationModel> locationModel = (json.decode(res.bodyString) as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();
      //inspect(locationModel);
      locationProvider.location(locationModel);
      //inspect(dishModel);
      //inspect(dishModel[0]);
      //inspect(DishModel());
      //DishModel dishModel;
      //print(dishModel.toJson());

      //print(dishModel);
      //inspect(dishModel);
    } catch (e) {
      print(e);
    }
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<SellerService>(context).addressbySeller(27),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }
            final List<SellerAddress> sellerAddress =
                (json.decode(snapshot.data.bodyString) as List)
                    .map((e) => SellerAddress.fromJson(e))
                    .toList();
            return _buildAddress(context, sellerAddress);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  ListView _buildAddress(
      BuildContext context, List<SellerAddress> sellerAddress) {
    return ListView.builder(
      itemCount: sellerAddress.length,
      itemBuilder: (context, index) => LocationButton(
        index: index,
        sellerAddress: sellerAddress[index],
        dishModel: dishModel,
      ),
    );
  }
}
