import 'package:debarrioapp/services/seller_service.dart';
import 'package:debarrioapp/providers/home_provider.dart';
import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';

import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';

import '../../../utilsFunctions.dart';
import 'profile_text_field_item.dart';

class ProfileUpdate extends StatelessWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController _restaurantName = TextEditingController();
    final homeBloc = Provider.of<HomeBloc>(context, listen: false);
    final profileBloc = Provider.of<ProfileBloc>(context);
    final appBar = PreferredSize(
      child: AppBarOptionSix(
        headerTitle: 'Editar datos personales',
        leftIconAction: () => Navigator.pop(context),
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileTextField(
                title: 'Nombre del restaurante',
                description: homeBloc.sellerAddress!.seller!.restaurantName,
                fieldType: 1,
              ),
              ProfileTextField(
                title: 'Nombre y apellidos',
                description: homeBloc.sellerAddress!.seller!.user!.username ==
                        homeBloc.sellerAddress!.seller!.user!.phoneNumber
                    ? ''
                    : homeBloc.sellerAddress!.seller!.user!.username,
                fieldType: 2,
              ),
              ProfileTextField(
                title: 'Correo electrónico',
                description: homeBloc.sellerAddress!.seller!.user!.email ==
                        homeBloc.sellerAddress!.seller!.user!.phoneNumber
                    ? ''
                    : homeBloc.sellerAddress!.seller!.user!.email,
                fieldType: 3,
              ),
              ProfileTextField(
                title: 'Celular',
                description: homeBloc.sellerAddress!.seller!.user!.phoneNumber,
                fieldType: 4,
              ),
              ProfileTextField(
                title: 'Dirección',
                description: homeBloc.sellerAddress!.address!.address,
                fieldType: 5,
              ),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavBtn(context, profileBloc, homeBloc),
      ),
    );
  }

  _bottomNavBtn(
      BuildContext context, ProfileBloc profileBloc, HomeBloc homeBloc) {
    return Container(
      padding: EdgeInsets.only(
        left: 28.0,
        right: 28.0,
        top: 24.0,
        bottom: 24.0,
      ),
      child: GenericButtonOrange(
        action: () {
          print('editar perfil');
          _validateForm(context, profileBloc, homeBloc);
          profileBloc.onUpdated();
        },
        disable: false,
        text: 'GUARDAR',
      ),
    );
  }

  _validateForm(
      BuildContext context, ProfileBloc profileBloc, HomeBloc homeBloc) async {
    if (!cZeroStr(profileBloc.restaurantName) &&
        !cZeroStr(homeBloc.sellerAddress!.seller!.restaurantName)) {
      print('Ingresa el restaurant');
      return;
    } else if (!cZeroStr(profileBloc.fullName) &&
        !cZeroStr(homeBloc.sellerAddress!.seller!.user!.username)) {
      print('Ingresa el nombre');
      return;
    } else if (!cZeroStr(profileBloc.email) &&
        !cZeroStr(homeBloc.sellerAddress!.seller!.user!.email)) {
      print('Ingresa el email');
      return;
    }
    print(profileBloc.restaurantName);
    print(profileBloc.fullName);
    print(profileBloc.email);
    homeBloc.sellerAddress!.seller!.restaurantName = profileBloc.restaurantName;
    homeBloc.sellerAddress!.seller!.user!.email = profileBloc.email;
    homeBloc.sellerAddress!.seller!.user!.username = profileBloc.fullName;
    profileBloc.removeAll();
    Routes.sailor.navigate(
      Routes.PROFILE_HOME_SCREEN,
      navigationType: NavigationType.pushReplace,
    );
    await Provider.of<SellerService>(context, listen: false).putSeller(
      homeBloc.sellerAddress!.seller!.user!.id!,
      homeBloc.sellerAddress!.seller!.restaurantName!,
    );
  }
}
