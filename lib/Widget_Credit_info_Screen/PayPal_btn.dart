import 'package:flutter/material.dart';

class PayPalBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.3,
      child: RaisedButton.icon(
        onPressed: () {},
        color: Colors.blue[900],
        highlightColor: Colors.blue,
        icon: Icon(
          Icons.payment_outlined,
          color: Colors.white,
        ),
        label: Text(
          "PAYPAL",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
