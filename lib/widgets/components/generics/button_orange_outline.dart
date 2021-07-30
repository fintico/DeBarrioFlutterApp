import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/widgets/components/button.dart';

class GenericButtonOrangeOutline extends StatelessWidget {
  final String text;
  final bool disable;
  final Function action;

  const GenericButtonOrangeOutline(
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
          DBStyles.WHITE,
          DBStyles.WHITE,
          DBStyles.GRAY_2,
        ],
        textColors: [
          DBColors.RED_DARK_1,
          DBColors.RED_DARK_1,
          DBColors.RED_DARK_1,
        ],
        disable: this.disable,
        action: action,
        border: Border.all(color: DBColors.RED_DARK_1),
      ),
    );
  }
}
