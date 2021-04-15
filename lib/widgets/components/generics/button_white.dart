import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import '../button.dart';

class GenericButtonWhite extends StatelessWidget {
  final String text;
  final bool disable;
  final Function action;
  const GenericButtonWhite({
    Key key,
    @required this.text,
    @required this.disable,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonWidget(
        text: this.text,
        buttonColors: [
          DBColors.WHITE,
          DBColors.GRAY_5,
          DBColors.GRAY_3,
        ],
        textColors: [
          DBStyles.BLACK,
          DBStyles.BLACK,
          DBStyles.GRAY_2,
        ],
        disable: this.disable,
        action: action,
        border: true,
      ),
    );
  }
}
