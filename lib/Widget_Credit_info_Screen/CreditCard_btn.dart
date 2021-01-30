import 'package:flutter/material.dart';

class CreditBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.3,
      child: RaisedButton(
        onPressed: () {},
        color: Colors.redAccent,
        highlightColor: Colors.grey,
        child: Text(
          "Tarjeta de credito",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
