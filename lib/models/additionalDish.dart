import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdditionalDish {
  static final AdditionalDish _additionalDish = new AdditionalDish._internal();

  int id;
  String additionalDescription;
  double price;
  bool isFree;

  AdditionalDish._internal();

  factory AdditionalDish() {
    return _additionalDish;
  }
}

final additionalDish = AdditionalDish();
