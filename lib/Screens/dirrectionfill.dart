import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'Registration/map_loaction_set.dart';

class DirectionForm extends StatefulWidget {
  @override
  _DirectionFormState createState() => _DirectionFormState();
}

class _DirectionFormState extends State<DirectionForm> {
  User user;
  bool init = false;
  DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    if (!init) {
      user = Provider.of<User>(context);
      init = true;
    }
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
      appBar: appBar,
      backgroundColor: HexColor("#f2f2f2"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height * 0.08,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () async {
              await database.setUserData(user);
              Navigator.pop(context);
            },
            child: Text("Guardar"),
            color: Colors.red,
            textColor: Colors.white,
          ),
        ),
      ),
      body: Container(
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
                    "Dirrecion actual",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                indent: 16.0,
                endIndent: 100,
              ),
              Container(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 16),
                              child: Text(
                                index == 0
                                    ? "Nuveva Direccion"
                                    : "Direccion $index",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LocationSetter(
                                                fromUserProfile: true,
                                                indexToChange:
                                                    user.address.length > index
                                                        ? index
                                                        : -1,
                                              )));
                                },
                                decoration: InputDecoration(
                                    hintText: user.address.length > index
                                        ? '${user.address[index].addressString}'
                                        : "no establecido",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                            ),
                            InkWell(
                              child: index > 0
                                  ? Icon(Icons.delete)
                                  : Icon(Icons.more_vert),
                              onTap: () {
                                if (user.address.length > index && index != 0) {
                                  setState(() {
                                    bool isRemoved = user.address
                                        .remove(user.address[index]);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
