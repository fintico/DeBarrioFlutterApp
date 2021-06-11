import 'package:flutter/material.dart';

import 'package:debarrioapp/constants/text_style.dart' as DBStyle;

TextStyle numberStyle = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_M,
  DBStyle.FONT_HEIGHT_M,
  0,
  DBStyle.FONT_WEIGHT_SEMI_BOLD,
);

const labelStyle = TextStyle(
  color: DBStyle.GRAY_2,
  fontFamily: DBStyle.FONT_FAMILY,
  fontSize: DBStyle.FONT_SYZE_M,
  letterSpacing: 0.0,
  fontWeight: DBStyle.FONT_WEIGHT_REGULAR,
  height: DBStyle.FONT_HEIGHT_M,
);

TextStyle bottonDetailDeleteTitleModalStyle = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_H3,
  DBStyle.FONT_HEIGHT_H3,
  0.0,
  DBStyle.FONT_WEIGHT_SEMI_BOLD,
);
TextStyle bottonDetailDeleteSubTitleModalStyle = DBStyle.getStyle(
  DBStyle.GRAY_2,
  DBStyle.FONT_SYZE_M,
  DBStyle.FONT_HEIGHT_M,
  0.0,
  DBStyle.FONT_WEIGHT_REGULAR,
);

TextStyle addPaymentMethodStyle = DBStyle.getStyle(
  DBStyle.GREEN,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0.8,
  DBStyle.FONT_WEIGHT_BOLD,
);

TextStyle notifyTitleStyle = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0,
  DBStyle.FONT_WEIGHT_SEMI_BOLD,
);

TextStyle notifySubTitleStyle = DBStyle.getStyle(
  DBStyle.BLACK,
  DBStyle.FONT_SYZE_S,
  DBStyle.FONT_HEIGHT_S,
  0,
  DBStyle.FONT_WEIGHT_REGULAR,
);
