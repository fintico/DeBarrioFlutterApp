import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/angle_right.dart';
import 'package:debarrioapp/widgets/components/icons/user.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

class ListTitleButton extends StatefulWidget {
  final Function action;
  final String title;
  final Widget icon;
  ListTitleButton({
    Key key,
    @required this.action,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  _ListTitleButtonState createState() => _ListTitleButtonState();
}

class _ListTitleButtonState extends State<ListTitleButton> {
  bool state = false;
  Color colorBackIcon = DBColors.RED_LIGHT;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: DBColors.WHITE,
      child: InkWell(
        onTap: widget.action,
        onLongPress: () {
          state = true;
          //colorBackIcon = DBColors.RED_LIGHT;
          setState(() {});
        },
/*         hoverColor: DBColors.GRAY_6,
        splashColor: DBColors.GRAY_6,
        highlightColor: DBColors.GRAY_6, */
        child: Container(
          width: double.infinity,
          height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.zero,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 28.0,
                right: 28.0,
              ),
              //decoration: BoxDecoration(color: DBColors.BLUE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 44.0,
                        width: 44.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          //color: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: widget.icon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.left,
                          style: DBStyles.getStyle(
                            DBStyles.BLACK,
                            DBStyles.FONT_SYZE_M,
                            DBStyles.FONT_HEIGHT_M,
                            0,
                            DBStyles.FONT_WEIGHT_REGULAR,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AngleRightIcon(
                    height: 20.0,
                    width: 20.0,
                    color: DBColors.RED,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
