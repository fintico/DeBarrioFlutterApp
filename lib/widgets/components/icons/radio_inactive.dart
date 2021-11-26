import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RadioInactiveIcon extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const RadioInactiveIcon({
    Key? key,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        'assets/icons/radio_inactive.svg',
        height: this.height,
        width: this.width,
        color: this.color,
      ),
    );
  }
}
