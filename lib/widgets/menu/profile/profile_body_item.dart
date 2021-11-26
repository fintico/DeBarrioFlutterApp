import 'package:debarrioapp/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import '../../../utilsFunctions.dart';
import 'profile_style.dart';

class ProfileBody extends StatelessWidget {
  final home = homeProvider<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 28.0),
          child: Text(
            'DATOS PERSONALES',
            style: titleStyle,
            textAlign: TextAlign.start,
          ),
        ),
        _profileData(
            subTitle: 'ID de usuario',
            description: '${home.sellerAddress!.seller!.user!.id}'
            /* ? homeBloc.sellerAddress.seller.user.id
                    : "No hay información", */
            ),
        _profileData(
          subTitle: 'Nombre de restaurante',
          description: cZeroStr(home.sellerAddress!.seller!.restaurantName)
              ? home.sellerAddress!.seller!.restaurantName!
              : "No hay información",
        ),
        _profileData(
          subTitle: 'Nombre y Apellidos',
          description: cZeroStr(home.sellerAddress!.seller!.user!.username!)
              ? home.sellerAddress!.seller!.user!.username! ==
                      home.sellerAddress!.seller!.user!.phoneNumber!
                  ? 'No hay información'
                  : home.sellerAddress!.seller!.user!.username!
              : "No hay información",
        ),
        _profileData(
          subTitle: 'Correo electrónico',
          description: cZeroStr(home.sellerAddress!.seller!.user!.email)
              ? home.sellerAddress!.seller!.user!.email! ==
                      home.sellerAddress!.seller!.user!.phoneNumber
                  ? 'No hay información'
                  : home.sellerAddress!.seller!.user!.email!
              : "No hay información",
        ),
        _profileData(
          subTitle: 'Celular',
          description: cZeroStr(home.sellerAddress!.seller!.user!.phoneNumber!)
              ? home.sellerAddress!.seller!.user!.phoneNumber!
              : "No hay información",
        ),
        _profileData(
          subTitle: 'Dirección',
          description: cZeroStr(home.sellerAddress!.address!.address!)
              ? home.sellerAddress!.address!.address!
              : "No hay información",
        ),
      ],
    );
  }

  _profileData({String? subTitle, String? description}) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTitle!,
            style: subTitleStyle,
            textAlign: TextAlign.start,
          ),
          Text(
            description!,
            style: descriptionStyle,
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Divider(
              color: DBColors.BLUE_LIGHT_2,
              height: 1.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
