import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoneyIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  const MoneyIcon(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/money.svg',
      height: this.height,
      width: this.width,
      color: this.color,
    );
  }
}
