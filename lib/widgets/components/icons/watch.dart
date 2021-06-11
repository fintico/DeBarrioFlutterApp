import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WatchIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const WatchIcon({
    Key key,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/watch.svg',
      height: this.height,
      width: this.width,
      color: this.color,
    );
  }
}
