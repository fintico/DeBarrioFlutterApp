import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/Adicionalas.dart';
import 'package:debarrioapp/Services/FirebaseFireStoreService.dart';
import 'package:debarrioapp/Services/FirebaseStorageService.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_eight.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;

import '../utilsFunctions.dart';

class FullInfoProd extends StatefulWidget {
  @override
  _FullInfoProdState createState() => _FullInfoProdState();
}

class _FullInfoProdState extends State<FullInfoProd> {
  User user;
  PostedDish postedDish;
  List<String> dayTime = [
    '12 AM',
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM'
  ];
  DatabaseService database = DatabaseService();
  bool loading = false;
  StorageService storage = StorageService();

  TextStyle titleStyle = DBStyle.getStyle(
    DBStyle.GRAY_2,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0.0,
    DBStyle.FONT_WEIGHT_BOLD,
  );
  TextStyle subTitleStyle = DBStyle.getStyle(
    DBStyle.GRAY_2,
    DBStyle.FONT_SYZE_XS,
    DBStyle.FONT_HEIGHT_XS,
    0.0,
    DBStyle.FONT_WEIGHT_BOLD,
  );
  TextStyle descriptionDishStyle = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_H3,
    DBStyle.FONT_HEIGHT_H3,
    0.0,
    DBStyle.FONT_WEIGHT_SEMI_BOLD,
  );
  TextStyle descriptionStyle = DBStyle.getStyle(
    DBStyle.BLACK,
    DBStyle.FONT_SYZE_M,
    DBStyle.FONT_HEIGHT_M,
    0.0,
    DBStyle.FONT_WEIGHT_REGULAR,
  );
  TextStyle stateOnStyle = DBStyle.getStyle(
    DBStyle.GREEN,
    DBStyle.FONT_SYZE_XS,
    DBStyle.FONT_HEIGHT_XS,
    0.0,
    DBStyle.FONT_WEIGHT_BOLD,
  );
  TextStyle stateOFFStyle = DBStyle.getStyle(
    DBStyle.GRAY_2,
    DBStyle.FONT_SYZE_XS,
    DBStyle.FONT_HEIGHT_XS,
    0.0,
    DBStyle.FONT_WEIGHT_BOLD,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressFromCoOrdinates();
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    postedDish = Provider.of<PostedDish>(context, listen: false);
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
    ); */
    final appBar = PreferredSize(
        child: Container(
          child: AppBarOptionEight(
            leftIconAction: () => Navigator.pop(context),
            headerTitle: 'Detalle de la publicación',
            rightIconAction: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Adicionalas())),
          ),
        ),
        preferredSize: Size.fromHeight(56.0));
    var additionText = TextEditingController();
    if (cZeroStr(postedDish.additionDish)) {
      additionText.text = postedDish.additionDish[0].additionName;
    }
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: DBColors.GRAY_8,
        /* bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadingOverlay(
            color: Colors.black,
            opacity: .7,
            isLoading: loading,
            progressIndicator: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              color: Colors.white,
            ),
            child: postedDish.salesDate.isBefore(DateTime.now())
                ? Container(
                    width: 1,
                    height: 1,
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () async {
                        final result = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Adicionalas()));
                        setState(() {});
                      },
                      child: Text("Agregar adiciones"),
                      textColor: Colors.white,
                    ),
                  ),
          ),
        ), */
        body: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          width: (MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PUBLICACIÓN #${postedDish.salesNumber}",
                          style: titleStyle,
                        ),
                        postedDish.salesDate.isAfter(DateTime.now())
                            ? stateOnBox()
                            : stateOffBox(),
                        //stateBox(),
                        /* Text(
                            postedDish.salesDate.isAfter(DateTime.now())
                                ? "Venta en Curso"
                                : "Venta Finalizada",
                            style: TextStyle(fontSize: 15)), */
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: getDishPicture,
                  child: postedDish.dishPictureURI != null
                      ? Image.network(
                          postedDish.dishPictureURI,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/images/carouselfirst.png'),
                          ),
                        ),
                ),
                SizedBox(height: 20),
                detailsDish(
                  title: 'NOMBRE DEL PLATO',
                  description: postedDish.name,
                  descriptionStyle: descriptionDishStyle,
                ),
                detailsDish(
                  title: 'CATEGORÍA',
                  description: postedDish.category,
                  descriptionStyle: descriptionStyle,
                ),
                detailsDish(
                  title: 'STOCK DE PORCIONES',
                  description: postedDish.totalService,
                  descriptionStyle: descriptionStyle,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 10.0,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FECHA DE ENTREGA',
                              style: subTitleStyle,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(postedDish.salesDate),
                              style: descriptionStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 95.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HORARIO',
                                style: subTitleStyle,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "${dayTime[postedDish.startTime.hour]} - ${dayTime[postedDish.endTime.hour]}",
                                style: descriptionStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 10.0,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRECIO CON DELIVERY',
                              style: subTitleStyle,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "S/${postedDish.priceWithDelivery}",
                              style: descriptionStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 80.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRECIO CON RECOJO',
                                style: subTitleStyle,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "S/${postedDish.originalPrice}",
                                style: descriptionStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //detailsDishShape(),
                detailsDish(
                    title: 'UBICACIÓN ACTUAL',
                    description: postedDish.addressString,
                    descriptionStyle: descriptionStyle),

                /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("Plato vender",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(postedDish.name),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text("Categoria",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(postedDish.category),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text("Stock de pociones",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(postedDish.totalService),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text("Fechas De venta",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(DateFormat('dd/MM/yyyy')
                                      .format(postedDish.salesDate)

                                  // postedDish.salesDate
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text("Horario",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                  "${dayTime[postedDish.startTime.hour]} - ${dayTime[postedDish.endTime.hour]}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text("Precio con delivery",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text("S/${postedDish.priceWithDelivery}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text("Precio con recojo",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text("S/${postedDish.originalPrice}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("Ubicacion actual",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(postedDish.addressString != null
                        ? postedDish.addressString
                        : ''),
                  ),
                ),
                SizedBox(
                  height: 20,
                ), */
                if (cZeroStr(postedDish.additionDish))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Adicionales",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (cZeroStr(postedDish.additionDish))
                  Container(
                    // height: MediaQuery.of(context).size.height/20,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      readOnly: true,
                      controller: additionText,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () => {_settingModalBottomSheet(context)},
                        ),
                        border: OutlineInputBorder(),
                        hintText: "${postedDish.additionDish[0].additionName}",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAddressFromCoOrdinates() async {
    var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(
        postedDish.currentLocation.latitude,
        postedDish.currentLocation.longitude));
    var first = address.first;
    setState(() {
      postedDish.addressString = first.addressLine;
    });
  }

  Future<void> getDishPicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      loading = true;
    });
    try {
      postedDish.dishPictureURI =
          await storage.uploadUserProfile(image, 'PostedDish', postedDish.id);
      await database.setPostedDishData(postedDish);
    } finally {
      setState(() {
        loading = false;
      });
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
              child: ListView.builder(
                itemCount: postedDish.additionDish.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 32.0, bottom: 10),
                    child: Text(
                      "${postedDish.additionDish[index].additionName}   S/${postedDish.additionDish[index].price}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  Widget stateOnBox() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        width: 62.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: DBColors.GREEN_LIGHT,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: DBColors.GREEN,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Text(
              'ACTIVA',
              style: stateOnStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget stateOffBox() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        width: 86.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: DBColors.GRAY_4,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 6.0,
              width: 6.0,
              decoration: BoxDecoration(
                color: DBColors.GRAY_2,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Text(
              'FINALIZADA',
              style: stateOFFStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsDish({
    String title,
    String description,
    TextStyle descriptionStyle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 10.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subTitleStyle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            description,
            style: descriptionStyle,
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

  Widget detailsDishShape() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 10.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              /* padding: const EdgeInsets.symmetric(
                            horizontal: 60.0,
                            vertical: 10.0,
                          ), */
              width: MediaQuery.of(context).size.width * 0.43,
              //height: 20.0,
              decoration: BoxDecoration(
                //color: DBColors.GREEN,
                border: Border(
                  top: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                  right: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FECHA DE ENTREGA',
                    style: subTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'FECHA DE ENTREGA',
                    style: descriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              /* padding: const EdgeInsets.symmetric(
                            horizontal: 60.0,
                            vertical: 10.0,
                          ), */
              width: MediaQuery.of(context).size.width * 0.43,
              //height: 20.0,
              decoration: BoxDecoration(
                //color: DBColors.GREEN,
                border: Border(
                  top: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                  /* left: BorderSide(
                                color: DBColors.BLUE_LIGHT_2,
                                width: 1.0,
                              ), */
                  bottom: BorderSide(
                    color: DBColors.BLUE_LIGHT_2,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FECHA DE ENTREGA',
                      style: subTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'FECHA DE ENTREGA',
                      style: descriptionStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
