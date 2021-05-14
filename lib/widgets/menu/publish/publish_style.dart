import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/text_style.dart' as DBStyle;

//publish card
TextStyle titleCardStyle = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_L,
  DBStyle.FONT_HEIGHT_L,
  0,
  DBStyle.FONT_WEIGHT_SEMI_BOLD,
);

TextStyle subtitleCardStyle = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0,
  DBStyle.FONT_WEIGHT_REGULAR,
);

TextStyle priceCardStyle = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0.0,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle publishtitleDetailStyle = DBStyle.getStyle(
  DBStyle.GRAY_7,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0.0,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle stateOnStyle = DBStyle.getStyle(
  DBStyle.GREEN,
  DBStyle.FONT_SYZE_XS,
  DBStyle.FONT_HEIGHT_XS,
  0.0,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle stateOFFStyle = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_XS,
  DBStyle.FONT_HEIGHT_XS,
  0.0,
  DBStyle.FONT_WEIGHT_BOLD,
);
