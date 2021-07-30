/* import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:debarrioapp/ServicesFire/FirebaseStorageService.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/generics/button_white.dart';
import 'package:debarrioapp/widgets/components/icons/angle_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  DatabaseService database = DatabaseService();
  bool loading = false;
  StorageService storage = StorageService();
  String userName, restaurantName, email;

  TextStyle titleAlert = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_H3,
    DBStyle.FONT_HEIGHT_H3,
    0.0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );

  TextStyle subTitleAlert = DBStyle.getStyle(
    DBStyle.GRAY_1,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0.0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
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
    ); */
    final appBar = PreferredSize(
        child: AppBarOptionSix(
          headerTitle: 'Editar datos personales',
          leftIconAction: () => Navigator.pop(context),
        ),
        preferredSize: Size.fromHeight(56.0));
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: DBColors.WHITE,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          color: DBColors.WHITE,
          padding: EdgeInsets.only(
            left: 28.0,
            right: 28.0,
            top: 24.0,
            bottom: 24.0,
          ),
          child: GenericButtonOrange(
            action: () {
              checkInputs();
            },
            disable: false,
            text: 'GUARDAR',
          ),
        ),
        /* Padding(
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
                    onPressed: () {
                      checkInputs();
                    },
                    child: Text("Guardar"),
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ), */
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
                    height: 50.0,
                  ),
                  _restaurantNameLabel(
                    title: 'Nombre del restaurante',
                    description: user.restaurantName,
                  ),
                  _personNameLabel(
                    title: 'Nombre y apellidos',
                    description: user.name,
                  ),
                  _emailLabel(
                    title: 'Correo electrónico',
                    description: user.email,
                  ),
                  _phoneNumberLabel(
                    title: 'Celular',
                    description: user.phoneNumber,
                  ),
                  _addressLabel(
                    title: 'Dirección',
                    description: user.address[0].addressString,
                  ),
                  /* Padding(
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
                      onChanged: (value) => restaurantName = value,
                      decoration: InputDecoration(
                          hintText: cZeroStr(user.restaurantName)
                              ? user.restaurantName
                              : 'Nombra de restaurente',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  Container(
                    height: 30,
                  ), */
                  /* Padding(
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
                      onChanged: (value) => userName = value,
                      decoration: InputDecoration(
                          hintText: cZeroStr(user.name)
                              ? user.name
                              : 'Nombre y apellido',
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
                      onChanged: (value) => email = value,
                      decoration: InputDecoration(
                          hintText: cZeroStr(user.email)
                              ? user.email
                              : 'Carlos electronio',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  Container(
                    height: 30,
                  ), */
                  /* Padding(
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
                  ), */
                  /* Padding(
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
                  ) */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkInputs() async {
    //TODO: Validate values show error on the fields remained empty
    if ((cZeroStr(userName) && cZeroStr(email) && cZeroStr(restaurantName))) {
      user.name = userName;
      user.restaurantName = restaurantName;
      user.email = email;
      setState(() {
        loading = true;
      });
      await database.setUserData(user);
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      //  Set Error on respective fields
    } else {
      print('No hay datos llenados');
    }
  }

  Widget _restaurantNameLabel({
    String title,
    String description,
    //String valueLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => restaurantName = value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _personNameLabel({
    String title,
    String description,
    //String valueLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => userName = value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailLabel({
    String title,
    String description,
    //String valueLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onChanged: (value) => email = value,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneNumberLabel({
    String title,
    String description,
    //String valueLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onTap: () => _phoneNumberAlert(context),
        //onChanged: (value) => valueLabel = value,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressLabel({
    String title,
    String description,
    //String valueLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15.0),
      child: TextField(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => DirectionForm()));
        },
        //onChanged: (value) => valueLabel = value,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintText: cZeroStr(description) ? description : null,
          hintStyle: TextStyle(
            color: cZeroStr(description) ? DBColors.BLACK : DBColors.GRAY_2,
          ),
          labelText: title,
          labelStyle: TextStyle(color: DBColors.GRAY_2),
          floatingLabelBehavior:
              cZeroStr(description) ? FloatingLabelBehavior.always : null,
          fillColor: DBColors.GREEN,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: DBColors.GRAY_2,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AngleDownIcon(
              height: 24.0,
              width: 24.0,
              color: DBColors.GRAY_2,
            ),
          ),
        ),
      ),
    );
  }

  void _phoneNumberAlert(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/verification.svg',
                height: 68.0,
                width: 68.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '¿Deseas cambiar tu \n número de celular?',
                style: titleAlert,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'De ser así, será necesario verificar \n el número por tu seguridad.',
                style: subTitleAlert,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32.0,
              ),
              Flexible(
                child: GenericButtonOrange(
                  text: 'ACEPTAR',
                  disable: false,
                  action: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Flexible(
                child: GenericButtonWhite(
                  text: 'CANCELAR',
                  disable: false,
                  action: () => Navigator.of(context).pop(),
                ),
              ),
              //FlutterLogo(size: 100.0),
            ],
          ),
        );
      },
    );
  }
}
 */
