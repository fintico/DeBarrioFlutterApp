import 'package:flutter/material.dart';

import 'creditcard_info__add_new_credit_card.dart';

class CreditSplash extends StatefulWidget {
  @override
  _CreditSplashState createState() => _CreditSplashState();
}

class _CreditSplashState extends State<CreditSplash> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.black87,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage("assets/images/Logo.png"),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
    );
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.2,
                    image: AssetImage("assets/images/card.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Text(
                    "Agrega un metodo" "\nde pago",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.yellow[600],
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    "Necisitas una alternativa de pago" "",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  child: Text(
                    "para continuar con tu compra",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RaisedButton(
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => CreditInfo()));
                        },
                        child: Text(
                          "Angregar metodo de pago",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
