import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RadioInactiveIcon extends StatelessWidget {
  final double height;
  final double width;
  const RadioInactiveIcon({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        'assets/icons/radio_inactive.svg',
        height: this.height,
        width: this.width,
      ),
    );
  }
}
