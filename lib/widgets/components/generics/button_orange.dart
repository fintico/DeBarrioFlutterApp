import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/widgets/components/button.dart';

class GenericButtonOrange extends StatelessWidget {
  final String text;
  final bool disable;
  final Function action;

  const GenericButtonOrange(
      {Key key,
      @required this.text,
      @required this.disable,
      @required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonWidget(
        text: this.text,
        buttonColors: [
          DBColors.RED,
          DBColors.RED_DARK,
          DBColors.GRAY_3,
        ],
        textColors: [
          DBStyles.WHITE,
          DBStyles.WHITE,
          DBStyles.GRAY_2,
        ],
        disable: this.disable,
        action: action,
        border: false,
      ),
    );
  }
}
