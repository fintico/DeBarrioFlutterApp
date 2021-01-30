import 'package:da_brello_ui/ModelClass/UserModel.dart';
import 'package:da_brello_ui/Services/FirebaseFireStoreService.dart';
import 'package:da_brello_ui/Services/FirebaseStorageService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../utilsFunctions.dart';
import 'editinfo__edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  DatabaseService database=DatabaseService();
  bool loading=false;
  StorageService storage=StorageService();
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
      actions: [
        IconButton(
          iconSize: 35,
          alignment: Alignment.centerRight,
          color: Colors.white,
          padding: const EdgeInsets.only(right: 14.0),
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
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
                    "Mi cuenta",
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
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        appBar: appBar,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.grey[100],
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => EdiRestoranttInfo()));
            },
                    child: Text("Editar informacion"),
                    color: Colors.grey[100],
                    elevation: 0.0,
                    textColor: Colors.black,
                  ),
                ),
              ),
            ],
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
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                GestureDetector(
                  onTap: getUserPicture,
                  child: CircleAvatar(
                    backgroundImage: cZeroStr(user.pictureUri)?NetworkImage(user.pictureUri):AssetImage("assets/images/bagshop.png"),
                    backgroundColor: Colors.grey[300],
                    radius: 60,
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   width: (MediaQuery.of(context).size.width),
                //   child: Text(
                //     "Cambiar foto de perfii",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: Colors.green,
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Information personal",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.blueGrey,
                  indent: 32.0,
                  thickness: 1,
                  endIndent: 96.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Id de usario",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "${user.id}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Nombre de restaurente",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    cZeroStr(user.restaurantName)?user.restaurantName:
                    "no establecido",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Nombre y Apellido",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    cZeroStr(user.name)?user.name:"no establecido",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Correo electronico",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    cZeroStr(user.email)?user.email:
                    "no establecido",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Celular",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    user.phoneNumber,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    "Direccion",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, left: 32.0),
                  width: (MediaQuery.of(context).size.width),
                  child: Text(
                    user.address[0].addressString,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserPicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      loading=true;
    });
    try {
      user.pictureUri =
      await storage.uploadUserProfile(image, 'UserProfile', user.id);
      await database.setUserData(user);
    }
    finally {
      setState(() {
        loading = false;
      });
    }
  }
}
