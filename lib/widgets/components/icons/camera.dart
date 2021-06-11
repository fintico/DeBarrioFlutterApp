import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraIcon extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const CameraIcon({
    Key key,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/camera.svg',
      height: this.height,
      width: this.width,
      color: this.color,
    );
  }
}
