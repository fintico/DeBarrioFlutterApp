import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/angle_left.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

class RadioListTitleButton extends StatefulWidget {
  final Function action;
  final String title;
  final bool isActive;
  RadioListTitleButton({
    Key key,
    @required this.action,
    @required this.title,
    @required this.isActive,
  }) : super(key: key);

  @override
  _RadioListTitleButtonState createState() => _RadioListTitleButtonState();
}

class _RadioListTitleButtonState extends State<RadioListTitleButton> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.action,
      //splashColor: DBColors.RED_DARK,
      child: Container(
        width: double.infinity,
        height: 64.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          //color: DBColors.WHITE,
          //color: DBColors.WHITE,
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              left: 28.0,
              right: 28.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: DBStyles.getStyle(
                    DBStyles.BLACK,
                    DBStyles.FONT_SYZE_L,
                    DBStyles.FONT_HEIGHT_L,
                    0.2,
                    DBStyles.FONT_WEIGHT_REGULAR,
                  ),
                ),
                iconPress(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconPress() {
    return state
        ? RadioActiveIcon(
            height: 20.0,
            width: 20.0,
          )
        : AngleLeftIcon(height: 20.0, width: 20.0, color: Colors.white);
  }
}
