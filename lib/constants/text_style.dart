library text_style;

import 'package:flutter/widgets.dart';

const String FONT_FAMILY = 'OpenSans';
const Color RED = const Color(0xFFE84A31);
const Color GREEN = const Color(0xFF52D176);
const Color YELLOW = const Color(0xFFFBCC42);
const Color GRAY_7 = const Color(0xFFBFBFBF);
const Color GRAY_2 = const Color(0xFF849299);
const Color GRAY_1 = const Color(0xFF4C6072);
const Color BLACK = const Color(0xFF333333);
const Color WHITE = const Color(0xFFFFFFFF);

const double FONT_SYZE_H1 = 28;
const double FONT_HEIGHT_H1 = 1.3333333333333333;
const double FONT_SYZE_H2 = 24;
const double FONT_HEIGHT_H2 = 1.3333333333333333;
const double FONT_SYZE_H3 = 20;
const double FONT_HEIGHT_H3 = 1.4;
const double FONT_SYZE_L = 16;
const double FONT_HEIGHT_L = 1.5;
const double FONT_SYZE_M = 14;
const double FONT_HEIGHT_M = 1.5714285714285714;
const double FONT_SYZE_S = 12;
const double FONT_HEIGHT_S = 1.3333333333333333;
const double FONT_SYZE_XS = 10;
const double FONT_HEIGHT_XS = 1.3333333333333333;
const FontWeight FONT_WEIGHT_BOLD = FontWeight.w700;
const FontWeight FONT_WEIGHT_SEMI_BOLD = FontWeight.w600;
const FontWeight FONT_WEIGHT_REGULAR = FontWeight.w400;

TextStyle getStyle(Color color, double fontSize, double height,
    double letterSpacing, FontWeight fontWeight,
    [TextDecoration? textDecoration]) {
  return TextStyle(
    color: color,
    fontFamily: FONT_FAMILY,
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    fontWeight: fontWeight,
    height: height,
    decoration: textDecoration,
  );
}
