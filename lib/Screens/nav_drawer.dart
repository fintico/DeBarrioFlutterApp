import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Screens/profile.dart';
import 'package:da_brello_ui/utilsFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calender_info_add_new_dish_to_publish.dart';
import 'misventas__currentOrders.dart';
import 'payoptbutton.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    final appBar = AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.grey[900],
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image(
          image: AssetImage("assets/images/Logo.png"),
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
          child: Column(
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
                    "Bienvenido!",
                    style: TextStyle(
                      color: Colors.yellowAccent[700],
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1120.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.white,
                          child: Container(
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: cZeroStr(user.pictureUri)
                                  ? NetworkImage(user.pictureUri)
                                  : AssetImage('assets/images/User.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        child: Text(
                          cZeroStr(user.name) ? user.name : "no establecido",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.4)),
    );
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.grey[100],
                          child: Center(
                            child: ListTile(
                                leading: Image(
                                  alignment: Alignment.center,
                                  image:
                                      AssetImage("assets/images/mi cuenta.JPG"),
                                ),
                                title: Text("Mi cuenta"),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProfileScreen(),
                                      ),
                                    ),
                                  },
                                ),
                                onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProfileScreen(),
                                        ),
                                      ),
                                    }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.grey[100],
                          child: Center(
                            child: ListTile(
                              leading: Image(
                                alignment: Alignment.center,
                                image:
                                    AssetImage("assets/images/Mispedidos.JPG"),
                              ),
                              title: Text("Mis pedidos"),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProfileScreen(),
                                    ),
                                  ),
                                },
                              ),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Misventas(
                                      isCurrentOrders: true,
                                    ),
                                  ),
                                ),
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.grey[100],
                          child: Center(
                            child: ListTile(
                                leading: Image(
                                  alignment: Alignment.center,
                                  image:
                                      AssetImage("assets/images/qvender.JPG"),
                                ),
                                title: Text("Quiero vender!"),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CalenderFill(),
                                      ),
                                    ),
                                  },
                                ),
                                onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CalenderFill(),
                                        ),
                                      ),
                                    }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.grey[100],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Misventas(
                                    isCurrentOrders: false,
                                  ),
                                ),
                              );
                            },
                            child: Center(
                              child: ListTile(
                                leading: Image(
                                  alignment: Alignment.center,
                                  image:
                                      AssetImage("assets/images/Misventas.JPG"),
                                  fit: BoxFit.fill,
                                ),
                                title: Text("Mis ventas"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          color: Colors.grey[100],
                          child: Center(
                            child: ListTile(
                                leading: Image(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                      "assets/images/MetodoDepago.JPG"),
                                ),
                                title: Text("MeTodo de pago"),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PayOptButton(
                                          fromOrder: false,
                                        ),
                                      ),
                                    ),
                                  },
                                ),
                                onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PayOptButton(
                                            fromOrder: false,
                                          ),
                                        ),
                                      ),
                                    }),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
