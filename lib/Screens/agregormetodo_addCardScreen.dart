import 'package:debarrioapp/ModelClass/BankCardModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/payoptbutton.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AgregorMetodo extends StatefulWidget {
  final bool fromOrder;
  final BankCard card;

  const AgregorMetodo({Key key, this.fromOrder, this.card}) : super(key: key);

  @override
  _AgregorMetodoState createState() => _AgregorMetodoState();
}

class _AgregorMetodoState extends State<AgregorMetodo> {
  User user;
  bool isSaved = false;
  BankCard bankCard = BankCard();
  TextEditingController _creditNum = TextEditingController();
  TextEditingController _cvv = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _expiry = TextEditingController();
  DatabaseService database = DatabaseService();

  @override
  void initState() {
    if (widget.card != null) {
      bankCard = widget.card;
      _creditNum.text = widget.card.cardNumber;
      _cvv.text = widget.card.cardKey;
      _name.text = widget.card.cardName;
      _expiry.text = widget.card.cardExpiry;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    if (widget.card != null && widget.card.cardNumber == null) {
      updateScreen();
      return Container();
    } else {
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
        actions: [
          if (widget.card != null)
            IconButton(
              iconSize: 35,
              alignment: Alignment.centerRight,
              color: Colors.white,
              padding: const EdgeInsets.only(right: 14.0),
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                _settingModalBottomSheet(context);
              },
            ),
        ],
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
        backgroundColor: HexColor("#f2f2f2"),
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                      onChanged: (value) => bankCard.cardNumber = value,
                      controller: _creditNum,
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
                                controller: _expiry,
                                onChanged: (value) =>
                                    bankCard.cardExpiry = value,
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
                                controller: _cvv,
                                onChanged: (value) => bankCard.cardKey = value,
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
                      controller: _name,
                      onChanged: (value) => bankCard.cardName = value,
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
                          value: isSaved,
                          onChanged: (value) {
                            setState(() {
                              isSaved = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PayOptButton(
                                          fromOrder: true,
                                        )));
                          },
                          child: Text("Cancelor"),
                          color: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            if (cZeroStr(bankCard.cardName) &&
                                cZeroStr(bankCard.cardKey) &&
                                2 < bankCard.cardKey.length &&
                                bankCard.cardKey.length < 5 &&
                                cZeroStr(bankCard.cardExpiry) &&
                                bankCard.cardExpiry.length == 5) {
                              if (isSaved) {
                                if (!cZeroStr(user.cards)) {
                                  user.cards = [];
                                }
                                if (widget.card == null) {
                                  bankCard.cardId = Uuid().v1();
                                  user.cards.add(bankCard);
                                } else {
                                  var index = user.cards.indexWhere((element) =>
                                      element.cardId == widget.card.cardId);
                                  user.cards[index] = bankCard;
                                }
                                database.setUserData(user);
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PayOptButton(
                                            fromOrder: widget.fromOrder,
                                          )));
                            } else {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.pink[50],
                                duration: Duration(seconds: 2),
                                padding: EdgeInsets.all(8.0),
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Please input Complete Details',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Text("Guardar"),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: MediaQuery.of(context).size.height * 0.025)
              ],
            ),
          ),
        ),
      );
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: new Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 32.0, bottom: 10),
                    child: Text(
                      "Estas seguero de eliminar este method de pago?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "No podras revertir esta accion",
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            for (BankCard card in user.cards) {
                              if (card.cardId == widget.card.cardId) {
                                user.cards.remove(card);
                                break;
                              }
                            }
                            widget.card.cardNumber = null;
                            database.setUserData(user);
                            user.notifyListeners();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Si,eliminar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () => {Navigator.pop(context)},
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void updateScreen() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
  }
}
