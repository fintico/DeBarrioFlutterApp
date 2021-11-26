import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleCheckOffIcon extends StatelessWidget {
  final double? height;
  final double? width;

  const CircleCheckOffIcon({
    Key? key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/circle_check_off.svg',
      height: this.height,
      width: this.width,
    );
  }
}
