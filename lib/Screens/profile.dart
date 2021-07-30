/* import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/ServicesFire/FirebaseStorageService.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  //User user;
  //DatabaseService database = DatabaseService();
  bool loading = false;
  StorageService storage = StorageService();

  TextStyle titleProfile = DBStyle.getStyle(
    DBStyle.GREEN,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0.8,
    DBStyle.FONT_WEIGHT_BOLD,
  );

  TextStyle titleStyle = DBStyle.getStyle(
    DBStyle.GRAY_1,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0,
    DBStyle.FONT_WEIGHT_BOLD,
  );
  TextStyle subTitleStyle = DBStyle.getStyle(
    DBStyle.GRAY_1,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );

  TextStyle descriptionStyle = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );

  @override
  Widget build(BuildContext context) {
    //user = Provider.of<User>(context);
    /* final appBar = AppBar(
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
    ); */
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Mi cuenta',
          leftIconAction: () => Navigator.pop(context),
        ),
        preferredSize: Size.fromHeight(56.0));
    return LoadingOverlay(
      isLoading: loading,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DBColors.BLUE_LIGHT_2,
          appBar: appBar,
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.14,
            color: DBColors.WHITE,
            padding: EdgeInsets.only(
              left: 28.0,
              right: 28.0,
              top: 24.0,
              bottom: 24.0,
            ),
            child: GenericButtonWhite(
              action: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => EdiRestoranttInfo()));
              },
              disable: false,
              text: 'EDITAR',
            ),
            /* child: Column(
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
                            context,
                            MaterialPageRoute(
                                builder: (_) => EdiRestoranttInfo()));
                      },
                      child: Text("Editar informacion"),
                      color: Colors.grey[100],
                      elevation: 0.0,
                      textColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ), */
          ),
          body: Container(
            /* height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top), */
            /* height: MediaQuery.of(context).size.height * 0.9, */
            width: (MediaQuery.of(context).size.width),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /* Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ), */
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: DBColors.BLUE_LIGHT_2,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: GestureDetector(
                            //onTap: getUserPicture,
                            child: CircleAvatar(
                              backgroundImage: cZeroStr(user.pictureUri)
                                  ? NetworkImage(user.pictureUri)
                                  : SvgPicture.asset(
                                      'assets/images/user.svg',
                                      height: 88.0,
                                      width: 88.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                              backgroundColor: Colors.grey[300],
                              radius: 60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                          ),
                          child: GestureDetector(
                            onTap: getUserPicture,
                            child: Text(
                              'CAMBIAR FOTO',
                              style: titleProfile,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    /* height: MediaQuery.of(context).size.height * 0.9, */
                    /* height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top), */
                    width: (MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      color: DBColors.WHITE,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30.0, left: 28.0),
                          width: (MediaQuery.of(context).size.width),
/*                           decoration: BoxDecoration(
                            border:
                                Border.all(width: 2.0, color: DBColors.GREEN),
                          ), */
                          child: Text(
                            'DATOS PERSONALES',
                            style: titleStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        _profileData(
                          subTitle: 'ID de usuario',
                          description: '${user.id}',
                        ),
                        _profileData(
                          subTitle: 'Nombre de restaurante',
                          description: cZeroStr(user.restaurantName)
                              ? user.restaurantName
                              : "No hay información",
                        ),
                        _profileData(
                          subTitle: 'Nombre y Apellidos',
                          description: cZeroStr(user.name)
                              ? user.name
                              : "No hay información",
                        ),
                        _profileData(
                          subTitle: 'Correo electrónico',
                          description: cZeroStr(user.email)
                              ? user.email
                              : "No hay información",
                        ),
                        _profileData(
                          subTitle: 'Celular',
                          description: cZeroStr(user.phoneNumber)
                              ? user.phoneNumber
                              : "No hay información",
                        ),
                        _profileData(
                          subTitle: 'Dirección',
                          description:
                              cZeroStr(user.address[0].addressString.toString())
                                  ? user.address[0].addressString
                                  : "No hay información",
                        ),
                      ],
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
                  /* Container(
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
                      cZeroStr(user.restaurantName)
                          ? user.restaurantName
                          : "no establecido",
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
                      cZeroStr(user.name) ? user.name : "no establecido",
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
                      cZeroStr(user.email) ? user.email : "no establecido",
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
                  ), */
                  /* Container(height: MediaQuery.of(context).size.height * 0.1), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileData({String subTitle, String description}) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 28.0),
      width: (MediaQuery.of(context).size.width),
/*       decoration:
          BoxDecoration(border: Border.all(width: 2.0, color: DBColors.GREEN)), */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subTitle,
            style: subTitleStyle,
            textAlign: TextAlign.start,
          ),
          Text(
            description,
            style: descriptionStyle,
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Divider(
              color: DBColors.BLUE_LIGHT_2,
              height: 1.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUserPicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      loading = true;
    });
    try {
      user.pictureUri =
          await storage.uploadUserProfile(image, 'UserProfile', user.id);
      await database.setUserData(user);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget elevatedButton() {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'EDITAR',
          style: TextStyle(color: DBColors.BLACK),
        ),
        style: ElevatedButton.styleFrom(
          primary: DBColors.WHITE,
          side: BorderSide(color: DBColors.BLACK),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
 */
