import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Widget_Credit_info_Screen/CreditCard_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget_Credit_info_Screen/PayPal_btn.dart';
import 'orderCompletion_done.dart';
import 'package:da_brello_ui/ModelClass/BankCardModel.dart';

class CreditInfo extends StatefulWidget {
  final BankCard card;

  const CreditInfo({Key key, this.card}) : super(key: key);

  @override
  _CreditInfoState createState() => _CreditInfoState();
}

class _CreditInfoState extends State<CreditInfo> {
  TextEditingController _creditNum = TextEditingController();
  TextEditingController _cvv = TextEditingController();
  TextEditingController _name = TextEditingController();
  User user;



  @override
  Widget build(BuildContext context) {
    user=Provider.of<User>(context);
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
      bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 0.8,
                color: Colors.white,
                endIndent: 22.0,
                indent: 22,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    "Metodo de pago",
                    style: TextStyle(
                      color: Colors.yellowAccent[700],
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(70)),
    );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "Elige un metodo de pago",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CreditBtn(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    PayPalBtn(),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, top: 20, bottom: 10),
                  child: Text(
                    "Elige un metodo de pago",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                child: Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0000-0000-0000-0000",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32.0, top: 20),
                          child: Text(
                            "Expiracion",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0, top: 20),
                          child: Text(
                            "CVV",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Padding(
                          padding: const EdgeInsets.only(
                              left: 32.0, right: 24.0, top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                hintText: "MM/AA",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Flexible(
                        child: new Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 32.0, top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "123",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, top: 20, bottom: 10),
                  child: Text(
                    "Nombre en la tarjeta",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                child: Container(
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Nombre y Apellido",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0, left: 20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Guardar tarjeta",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Switch(
                        activeColor: Colors.green,
                        value: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RaisedButton(
                      color: _creditNum.text.isEmpty ||
                              _cvv.text.isEmpty ||
                              _name.text.isEmpty
                          ? Colors.grey[400]
                          : Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        if (widget.card != null) {
                          int index=user.cards.indexWhere((element) => element.cardId==widget.card.cardId);
                          // widget.

                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OrderConpletion()));
                        }
                      },
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          color: (_creditNum.text.isEmpty ||
                                  _cvv.text.isEmpty ||
                                  _name.text.isEmpty)
                              ? Colors.blueGrey[700]
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: MediaQuery.of(context).size.height * 0.025)
            ],
          ),
        ),
      ),
    );
  }
}
