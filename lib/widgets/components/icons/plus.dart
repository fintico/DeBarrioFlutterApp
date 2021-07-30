import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlusIcon extends StatelessWidget {
  const PlusIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/oval.svg',
          height: 24.0,
          width: 24.0,
        ),
        SvgPicture.asset(
          'assets/icons/plus.svg',
          height: 12.0,
          width: 12.0,
        ),
      ],
    );
  }
}
