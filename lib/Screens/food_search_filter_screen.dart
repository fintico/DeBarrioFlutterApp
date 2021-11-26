import 'package:debarrioapp/utilProperties.dart';
import 'package:flutter/material.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class FoodSearchFilterScreen extends StatefulWidget {
  final Function? setCategory;

  const FoodSearchFilterScreen({Key? key, this.setCategory}) : super(key: key);

  @override
  _FoodSearchFilterScreenState createState() => _FoodSearchFilterScreenState();
}

class _FoodSearchFilterScreenState extends State<FoodSearchFilterScreen> {
  bool isDelievery = false;
  bool isTakeAway = false;
  bool isAlmuerza = false;
  bool isPiques = false;
  bool isCena = false;
  bool isDesayuno = false;
  bool isPostres = false;
  bool isPeruana = false;
  bool isItaliana = false;
  bool isJaponesa = false;
  bool isChaina = false;
  bool isFusion = false;
  bool isCarnivoro = false;
  bool isVegetariano = false;
  bool isVegano = false;
  bool isSinGluten = false;
  bool is0Day = false;
  bool is1Day = false;
  bool is2Day = false;
  bool is3Day = false;
  bool is4Day = false;
  bool is5Day = false;
  bool is6Day = false;
  bool is7Day = false;
  List<DateTime> toSendBack = [];

  Widget _fechasButton(String text, Color color, Color bordercolor, int index) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        setState(() {
          if (index == 0) {
            is0Day = !is0Day;
            if (is0Day) toSendBack.add(DateTime.now());
          } else if (index == 1) {
            is1Day = !is1Day;
            if (is1Day) toSendBack.add(DateTime.now().add(Duration(days: 1)));
          } else if (index == 2) {
            is2Day = !is2Day;
            if (is2Day) toSendBack.add(DateTime.now().add(Duration(days: 2)));
          } else if (index == 3) {
            is3Day = !is3Day;
            if (is3Day) toSendBack.add(DateTime.now().add(Duration(days: 3)));
          } else if (index == 4) {
            is4Day = !is4Day;
            if (is4Day) toSendBack.add(DateTime.now().add(Duration(days: 4)));
          } else if (index == 5) {
            is5Day = !is5Day;
            if (is5Day) toSendBack.add(DateTime.now().add(Duration(days: 5)));
          } else if (index == 6) {
            is6Day = !is6Day;
            if (is6Day) toSendBack.add(DateTime.now().add(Duration(days: 6)));
          } else if (index == 7) {
            is7Day = !is7Day;
            if (is7Day) toSendBack.add(DateTime.now().add(Duration(days: 7)));
          }
        });
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      color: color,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.grey[100],
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
          child: IconButton(
            color: Colors.grey[800],
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ),
      ],
    );
    return Scaffold(
      //backgroundColor: HexColor("#f2f2f2"),
      appBar: appBar,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () => {clearFilters()},
                    child: Text(
                      "Limpiar Filtros",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () => {updateCategory()},
                  child: Text(
                    "Aplicar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                child: Text(
                  "Filtra tus prefrencia",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[800],
                height: 2,
                indent: 24.0,
                thickness: 1,
                endIndent: 100.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 24.0, top: 32.0, bottom: 10.0),
                child: Text(
                  "Tipo de comida",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: RaisedButton.icon(
                                icon: Icon(Icons.delivery_dining),
                                shape: isDelievery
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isDelievery = !isDelievery;
                                  });
                                },
                                label: Text("Mis pedidos"),
                                color: Colors.blueGrey[100],
                                elevation: 0.0,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: RaisedButton.icon(
                                shape: isTakeAway
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isTakeAway = !isTakeAway;
                                  });
                                },
                                icon: Icon(Icons.shopping_bag_outlined),
                                label: Text("Inicio"),
                                elevation: 0.0,
                                color: Colors.blueGrey[100],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 24.0, top: 20.0, bottom: 10.0),
                child: Text(
                  "Tipo de comida",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isAlmuerza
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isAlmuerza = !isAlmuerza;
                                  });
                                },
                                child: Text("Almuerza"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isPiques
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isPiques = !isPiques;
                                  });
                                },
                                child: Text("Piques"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isCena
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isCena = !isCena;
                                  });
                                },
                                child: Text("Cena"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isDesayuno
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isDesayuno = !isDesayuno;
                                  });
                                },
                                child: Text("Desayuno"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isPostres
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isPostres = !isPostres;
                                  });
                                },
                                child: Text("Postres"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 24.0, top: 20.0, bottom: 10.0),
                child: Text(
                  "Estilo de comida",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isPeruana
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isPeruana = !isPeruana;
                                  });
                                },
                                child: Text("Peruana"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isItaliana
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isItaliana = !isItaliana;
                                  });
                                },
                                child: Text("Italiana"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isJaponesa
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isJaponesa = !isJaponesa;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Japonesa"),
                                ),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isChaina
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isChaina = !isChaina;
                                  });
                                },
                                child: Text("China"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isFusion
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isFusion = !isFusion;
                                  });
                                },
                                child: Text("Fusion"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 24.0, top: 20.0, bottom: 10.0),
                child: Text(
                  "Fechas",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton("Hoy", Colors.amber,
                              is0Day ? Colors.black : Colors.amber, 0),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 1)))}",
                              Colors.white,
                              is1Day ? Colors.black : Colors.white,
                              1),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 2)))}",
                              Colors.white,
                              is2Day ? Colors.black : Colors.white,
                              2),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 3)))}",
                              Colors.white,
                              is3Day ? Colors.black : Colors.white,
                              3),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 4)))}",
                              Colors.white,
                              is4Day ? Colors.black : Colors.white,
                              4),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 5)))}",
                              Colors.white,
                              is5Day ? Colors.black : Colors.white,
                              5),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 6)))}",
                              Colors.white,
                              is6Day ? Colors.black : Colors.white,
                              6),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: _fechasButton(
                              "${DateFormat('EEE dd MMM').format(DateTime.now().add(Duration(days: 7)))}",
                              Colors.white,
                              is7Day ? Colors.black : Colors.white,
                              7),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 24.0, top: 20.0, bottom: 10.0),
                child: Text(
                  "Estilo de vida",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isCarnivoro
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isCarnivoro = !isCarnivoro;
                                  });
                                },
                                child: Text("Carnivoro"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isVegetariano
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isVegetariano = !isVegetariano;
                                  });
                                },
                                child: Text("Vegetariano"),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                shape: isVegano
                                    ? RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5))
                                    : RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  setState(() {
                                    isVegano = !isVegano;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Vegano"),
                                ),
                                elevation: 0.0,
                                color: Colors.grey[300],
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: RaisedButton(
                              shape: isSinGluten
                                  ? RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5))
                                  : RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                setState(() {
                                  isSinGluten = !isSinGluten;
                                });
                              },
                              child: Text("Sin gluten"),
                              elevation: 0.0,
                              color: Colors.grey[300],
                              textColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  clearFilters() {
    setState(() {
      isDelievery = false;
      isTakeAway = false;
      isAlmuerza = false;
      isPiques = false;
      isCena = false;
      isDesayuno = false;
      isPostres = false;
      isPeruana = false;
      isItaliana = false;
      isJaponesa = false;
      isChaina = false;
      isFusion = false;
      isCarnivoro = false;
      isVegetariano = false;
      isVegano = false;
      isSinGluten = false;
      is0Day = false;
      is1Day = false;
      is2Day = false;
      is3Day = false;
      is4Day = false;
      is5Day = false;
      is6Day = false;
      is7Day = false;
    });
  }

  void updateCategory() {
    List<String> selectedCategory = [];
    if (isAlmuerza) selectedCategory.add(category[0]);
    if (isPiques) selectedCategory.add(category[1]);
    if (isCena) selectedCategory.add(category[2]);
    if (isDesayuno) selectedCategory.add(category[3]);
    if (isPostres) selectedCategory.add(category[4]);
    if (isPeruana) selectedCategory.add(category[5]);
    if (isItaliana) selectedCategory.add(category[6]);
    if (isJaponesa) selectedCategory.add(category[7]);
    if (isChaina) selectedCategory.add(category[8]);
    if (isFusion) selectedCategory.add(category[9]);
    if (isCarnivoro) selectedCategory.add(category[10]);
    if (isVegetariano) selectedCategory.add(category[11]);
    if (isVegano) selectedCategory.add(category[12]);
    if (isSinGluten) selectedCategory.add(category[13]);
    widget.setCategory!(selectedCategory, toSendBack);
    Navigator.pop(context);
  }
}
