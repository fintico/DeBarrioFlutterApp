import 'package:debarrioapp/widgets/components/icons/bag.dart';
import 'package:debarrioapp/widgets/components/icons/credit_card.dart';
import 'package:debarrioapp/widgets/components/icons/money.dart';
import 'package:debarrioapp/widgets/components/icons/payment_method.dart';
import 'package:debarrioapp/widgets/components/icons/post.dart';
import 'package:debarrioapp/widgets/components/icons/profit.dart';
import 'package:debarrioapp/widgets/components/icons/user.dart';
import 'package:debarrioapp/widgets/components/icons/wallet.dart';
import 'package:debarrioapp/widgets/components/list_title_button.dart';
import 'package:flutter/material.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';
import 'package:debarrioapp/Screens/profile.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_seven.dart';
import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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

  TextStyle titleStyle = DBStyle.getStyle(
    DBStyle.GRAY_1,
    DBStyle.FONT_SYZE_S,
    DBStyle.FONT_HEIGHT_S,
    0,
    DBStyle.FONT_WEIGHT_BOLD,
  );

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    /* final appBar = AppBar(
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
    ); */
    final appBar = PreferredSize(
      child: AppBarOptionSeven(
        leftIconAction: () => Navigator.pop(context),
        title: '¡Bienvenido!',
      ),
      preferredSize: Size.fromHeight(328.0),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: DBColors.BLACK,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        _myAccount(),
                        _myDivider('COMPRAS'),
                        _myBag(),
                        _myBilling(),
                        _myDivider('VENTAS'),
                        _toSell(),
                        _mySales(),
                        _myPosts(),
                        _myProfits(),
                        _myPaymentMethod(),
                        /* Padding(
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
                                        "assets/images/mi cuenta.JPG"),
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
                                  image: AssetImage(
                                      "assets/images/Mispedidos.JPG"),
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
                                    image: AssetImage(
                                        "assets/images/Misventas.JPG"),
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
                        ), */
                        SizedBox(
                          height: 100.0,
                        ),
                      ],
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

  Widget _myAccount() {
    return ListTitleButton(
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileScreen(),
          ),
        );
      },
      title: 'Mi cuenta',
      icon: UserIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myBag() {
    return ListTitleButton(
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Misventas(
              isCurrentOrders: true,
            ),
          ),
        );
      },
      title: 'Mis pedidos',
      icon: BagIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myBilling() {
    return ListTitleButton(
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PayOptButton(
              fromOrder: false,
            ),
          ),
        );
      },
      title: 'Métodos de pago',
      icon: CreditCardIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _toSell() {
    return ListTitleButton(
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalenderFill(),
          ),
        );
      },
      title: 'Vender',
      icon: MoneyIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _mySales() {
    return ListTitleButton(
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Misventas(
              isCurrentOrders: false,
            ),
          ),
        );
      },
      title: 'Mis ventas',
      icon: WalletIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myPosts() {
    return ListTitleButton(
      action: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalenderFill(),
          ),
        ); */
      },
      title: 'Mis publicaciones',
      icon: PostIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myProfits() {
    return ListTitleButton(
      action: () {
/*         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalenderFill(),
          ),
        ); */
      },
      title: 'Ganancias',
      icon: ProfitIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myPaymentMethod() {
    return ListTitleButton(
      action: () {
/*         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalenderFill(),
          ),
        ); */
      },
      title: 'Métodos de cobro',
      icon: PaymentMethodIcon(
        height: 28.0,
        width: 28.0,
        color: DBColors.RED,
      ),
    );
  }

  Widget _myDivider(String title) {
    return SizedBox(
      height: 80.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Divider(
              color: DBColors.BLUE_LIGHT_2,
              height: 1.0,
              indent: 28.0,
              endIndent: 28.0,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 298.0),
            child: Text(
              title,
              style: titleStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
