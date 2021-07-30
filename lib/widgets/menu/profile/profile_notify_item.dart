import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/widgets/components/icons/check_circle_on.dart';
import 'package:debarrioapp/widgets/components/icons/close.dart';
import 'package:debarrioapp/widgets/components/icons/plus_circle.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import 'profile_style.dart';

class ProfileNotify extends StatelessWidget {
  const ProfileNotify({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 13.0, right: 19.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: DBColors.GREEN_LIGHT,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 22.0, bottom: 22.0),
                  child: RadioActiveIcon(height: 20.0, width: 20.0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 20.0, bottom: 20.0),
                  child: Text(
                    '¡Listo! Guardamos tus cambios',
                    style: titleNotifyStyle,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
              child: InkWell(
                  onTap: () {
                    profileBloc.onGone();
                    print('disable notify');
                  },
                  child: CloseIcon(
                      height: 16.0, width: 16.0, color: DBColors.GREEN)),
            )
          ],
        ),
      ),
    );
  }
}
