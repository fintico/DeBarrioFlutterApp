import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:provider/provider.dart';

import 'package:sailor/sailor.dart';

import 'profile_body_item.dart';
import 'profile_header_item.dart';
import 'profile_notify_item.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = Provider.of<ProfileBloc>(context);
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Mi cuenta',
          leftIconAction: () => Routes.sailor.navigate(
            Routes.MENU_SCREEN,
            navigationType: NavigationType.pushReplace,
            transitions: [
              SailorTransition.fade_in,
              SailorTransition.slide_from_left
            ],
          ),
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: _bottomNavBtn(profileBloc),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(),
                  ProfileBody(),
                ],
              ),
              profileBloc.isUpdated
                  ? Visibility(
                      visible: !profileBloc.isGone,
                      child: Positioned(
                        bottom: 10.0,
                        right: 1.0,
                        left: 1.0,
                        child: ProfileNotify(),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _bottomNavBtn(ProfileBloc profileBloc) {
    return Container(
      padding: EdgeInsets.only(
        left: 28.0,
        right: 28.0,
        top: 24.0,
        bottom: 24.0,
      ),
      child: GenericButtonWhite(
        action: () {
          print('editar perfil');
          profileBloc.removeAllNotify();
          Routes.sailor.navigate(
            Routes.PROFILE_UPDATE_SCREEN,
            navigationType: NavigationType.push,
          );
        },
        disable: false,
        text: 'EDITAR',
      ),
    );
  }
}
