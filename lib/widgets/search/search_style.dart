import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/text_style.dart' as DBStyle;

//search inputs
TextStyle searchInput = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_M,
  DBStyle.FONT_HEIGHT_M,
  0.0,
  DBStyle.FONT_WEIGHT_REGULAR,
);

TextStyle hintSearchInput = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_M,
  DBStyle.FONT_HEIGHT_M,
  0.0,
  DBStyle.FONT_WEIGHT_REGULAR,
);

TextStyle cancelSearchTitle = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_XS,
  DBStyle.FONT_HEIGHT_XS,
  0.8,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle itemSearchTitle = DBStyle.getStyle(
  DBStyle.GRAY_1,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0.0,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle itemSearchDescription = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_M,
  DBStyle.FONT_HEIGHT_M,
  0.0,
  DBStyle.FONT_WEIGHT_SEMI_BOLD,
);
