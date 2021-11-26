import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_seven.dart';
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

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'package:sailor/sailor.dart';

import 'menu_style.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionSeven(
        leftIconAction: () => /* Navigator.pop(context) */
            Routes.sailor.navigate(
          Routes.HOME_SCREEN,
          navigationType: NavigationType.pushReplace,
        ),
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
        Routes.sailor.navigate(
          Routes.PROFILE_HOME_SCREEN,
          navigationType: NavigationType.pushReplace,
          transitions: [
            SailorTransition.fade_in,
            SailorTransition.slide_from_right
          ],
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
        Routes.sailor.navigate(
          Routes.ORDER_HOME_PAGE_SCREEN,
          navigationType: NavigationType.pushReplace,
          transitions: [
            SailorTransition.fade_in,
            SailorTransition.slide_from_right
          ],
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
        Routes.sailor.navigate(
          Routes.PAYMENT_METHOD_LIST_SCREEN,
          navigationType: NavigationType.pushReplace,
          transitions: [
            SailorTransition.fade_in,
            SailorTransition.slide_from_right
          ],
          params: {
            'isCreated': false,
          },
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
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalenderFill(),
          ),
        ); */
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
        Routes.sailor.navigate(
          Routes.SALE_LIST_SCREEN,
          navigationType: NavigationType.pushReplace,
          transitions: [
            SailorTransition.fade_in,
            SailorTransition.slide_from_right
          ],
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
        Routes.sailor.navigate(Routes.DISH_LIST_SCREEN,
            navigationType: NavigationType.pushReplace,
            transitions: [
              SailorTransition.fade_in,
              SailorTransition.slide_from_right
            ]);
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
