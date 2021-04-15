import 'package:flutter/material.dart';
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;

class ButtonWidget extends StatefulWidget {
  final String text;
  final List<Color> buttonColors;
  final List<Color> textColors;
  final bool disable;
  final Function action;
  final bool border;

  ButtonWidget({
    Key key,
    @required this.text,
    @required this.buttonColors,
    @required this.textColors,
    @required this.disable,
    @required this.action,
    @required this.border,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  int state = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.disable) this.state = 2;
    });
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          if (!widget.disable) this.state = 1;
        });
      },
      onTapUp: (details) {
        setState(() {
          if (!widget.disable) this.state = 0;
        });
      },
      onTap: widget.disable ? () {} : widget.action,
      child: Container(
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            //color: widget.buttonColors[state],
            color: widget.buttonColors[state],
            border: widget.border ? Border.all(color: DBStyle.BLACK) : null),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: DBStyle.getStyle(
                widget.textColors[state],
                DBStyle.FONT_SYZE_M,
                DBStyle.FONT_HEIGHT_M,
                0,
                DBStyle.FONT_WEIGHT_SEMI_BOLD),
          ),
        ),
      ),
    );
  }
}
