import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

class VerifySMSPageArgs extends BaseArguments {
  final String verifyType;
  final bool error;
  final String errorMsg;

  VerifySMSPageArgs({
    @required this.error,
    @required this.verifyType,
    @required this.errorMsg,
  });
}
