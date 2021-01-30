import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:da_brello_ui/Services/FirebaseStorageService.dart';
import 'package:da_brello_ui/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'dirrectionfill.dart';

class EdiRestoranttInfo extends StatefulWidget {
  @override
  _EdiRestoranttInfoState createState() => _EdiRestoranttInfoState();
}

class _EdiRestoranttInfoState extends State<EdiRestoranttInfo> {
  User user;
  DatabaseService database=DatabaseService();
  bool loading=false;
  StorageService storage=StorageService();
  String userName,restaurantName,email;
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
      appBar: appBar,
      backgroundColor: HexColor("#f2f2f2"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.08,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {},
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
                  onPressed: () {checkInputs();},
                  child: Text("Guardar"),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: LoadingOverlay(
        isLoading: loading,
        child: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          width: (MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "INFORMATION PERSONAL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Nombra de restaurente",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                  child: TextField(
                    onChanged: (value)=>
                      restaurantName=value
                    ,
                    decoration: InputDecoration(
                        hintText: cZeroStr(user.restaurantName)? user.restaurantName:'Nombra de restaurente',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Nombre y apellido",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                  child: TextField(
                    onChanged: (value)=> userName=value,
                    decoration: InputDecoration(
                        hintText: cZeroStr(user.name)?user.name:'Nombre y apellido',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Carlos electronio",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                  child: TextField(
                    onChanged: (value)=> email=value,
                    decoration: InputDecoration(
                        hintText:  cZeroStr(user.email)?user.email:'Carlos electronio',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Celular",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: user.phoneNumber,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Dirrecion",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 10, bottom: 16.0),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: Icon(Icons.arrow_drop_down_outlined),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DirectionForm()));
                          },
                        ),
                        hintText: '${user.address[0].addressString}',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkInputs() async {
    //TODO: Validate values show error on the fields remained empty
    if ((cZeroStr(userName)&&cZeroStr(email)&&cZeroStr(restaurantName))){
      user.name=userName;
      user.restaurantName=restaurantName;
      user.email=email;
      setState(() {
        loading=true;
      });
      await database.setUserData(user);
      setState(() {
        loading=false;
      });
      Navigator.pop(context);
    //  Set Error on respective fields
    }
  }
}
