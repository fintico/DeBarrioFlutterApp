import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterIcon extends StatelessWidget {
  final double height;
  final double width;
  final int type;
  final Color color;
  const FilterIcon(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.type,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //0: default, 1: pressed, 3 completed
    var asset = 'assets/icons/filter.svg';
    if (this.type == 0) {
      asset = 'assets/icons/filter.svg';
    }
    if (this.type == 1) {
      asset = 'assets/icons/filter_pressed.svg';
    }
    if (this.type == 2) {
      asset = 'assets/icons/filter_complete.svg';
    }
    return SvgPicture.asset(
      asset,
      height: this.height,
      width: this.width,
      color: this.color,
    );
  }
}
