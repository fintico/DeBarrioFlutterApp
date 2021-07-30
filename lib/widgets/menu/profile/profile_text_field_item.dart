import 'package:debarrioapp/providers/profile_provider.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:provider/provider.dart';

import '../../../utilsFunctions.dart';
import 'profile_style.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final String description;
  final int fieldType;
  const ProfileTextField(
      {Key key, this.title, this.description, this.fieldType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = Provider.of<ProfileBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 33.0),
      child: TextFormField(
        onChanged: (value) {
          print(value);
          _fieldType(profileBloc, fieldType, value);
        },
        //controller: controller,
        keyboardType: _keyboarType(fieldType),
        style: labelFormStyle,
        readOnly: fieldType > 3 ? true : false,
        onTap: () {
          _onTapType(fieldType);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 16.0, top: 21.0, bottom: 12.0),
          suffixIcon: fieldType == 5
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 11.0, bottom: 12.0, right: 12.0),
                  child: AngleDownIcon(
                    height: 24.0,
                    width: 24.0,
                    color: DBColors.GRAY_2,
                  ),
                )
              : SizedBox(
                  height: 0.0,
                ),
        ),
      ),
    );
  }

  _fieldType(ProfileBloc profileBloc, int type, String value) {
    switch (type) {
      case 1:
        return profileBloc.restaurantName = value;
        break;
      case 2:
        return profileBloc.fullName = value;
        break;
      case 3:
        return profileBloc.email = value;
        break;
      default:
      //return TextInputType.name;
    }
  }

  _onTapType(int type) {
    switch (type) {
      case 4:
        //return TextInputType.emailAddress;
        return print('phone');
        break;
      case 5:
        return print('dirección');
        break;
      default:
        return null;
    }
  }

  _keyboarType(int type) {
    switch (type) {
      case 3:
        return TextInputType.emailAddress;
        break;
      case 4:
        return TextInputType.phone;
        break;
      default:
        return TextInputType.name;
    }
  }
}
