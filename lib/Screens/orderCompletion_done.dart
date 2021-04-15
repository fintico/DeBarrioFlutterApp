import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/Screens/map_screen.dart';
import 'package:flutter/material.dart';

class OrderConpletion extends StatefulWidget {
  final Order order;

  const OrderConpletion({Key key, this.order}) : super(key: key);
  @override
  _OrderConpletionState createState() => _OrderConpletionState();
}

class _OrderConpletionState extends State<OrderConpletion> {
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
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
                    image: AssetImage("assets/images/bag.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Text(
                    "Buenazo!",
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
                    "Tu pedido ha sido realizado con",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  child: Text(
                    "exito.EI N' de orden es ${widget.order.id.substring(10)}",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Container(
                  child: Text(
                    "Recuerda que puedas revisar el estado de tu",
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
                    "pedido en la seccion Mis pedidos",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MapScreen()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Text("Mis pedidos"),
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
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MapScreen()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Text("Inicio"),
                                color: Colors.red,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
