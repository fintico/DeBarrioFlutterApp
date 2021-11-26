import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CloseIcon extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const CloseIcon(
      {Key? key,
      @required this.height,
      @required this.width,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/close.svg',
      height: this.height,
      width: this.width,
      color: this.color,
    );
  }
}
