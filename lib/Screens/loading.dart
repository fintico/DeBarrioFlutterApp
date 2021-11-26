import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    bool _saving = true;
    return Scaffold(
      body: LoadingOverlay(
        child: Container(),
        isLoading: _saving,
        progressIndicator: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [Colors.white],
        ),
      ),
    );
  }
}
