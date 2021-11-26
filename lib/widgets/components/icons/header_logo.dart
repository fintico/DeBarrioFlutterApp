import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderLogoIcon extends StatelessWidget {
  final double? height;
  final double? width;

  const HeaderLogoIcon({Key? key, @required this.height, @required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        'assets/images/header_logo.svg',
        height: this.height,
        width: this.width,
      ),
    );
  }
}
