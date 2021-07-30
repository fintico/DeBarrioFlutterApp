import 'dart:developer';

import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_six.dart';
import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:debarrioapp/widgets/components/icons/camera.dart';
import 'package:debarrioapp/widgets/components/icons/hint.dart';
import 'package:flutter/material.dart';

import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/credit_card.dart' as CreditCard;
import 'package:sailor/sailor.dart';

import '../../../utilsFunctions.dart';
import 'payment_method_alert_item.dart';
import 'payment_method_style.dart';

class PaymentMethodAddCard extends StatefulWidget {
  PaymentMethodAddCard({Key key}) : super(key: key);

  @override
  _PaymentMethodAddCardState createState() => _PaymentMethodAddCardState();
}

class _PaymentMethodAddCardState extends State<PaymentMethodAddCard> {
  CreditCardModel creditCard;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isActive = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionSix(
          leftIconAction: () => Routes.sailor.navigate(
                Routes.PAYMENT_METHOD_LIST_SCREEN,
                navigationType: NavigationType.pushReplace,
                transitions: [
                  SailorTransition.fade_in,
                  SailorTransition.slide_from_left,
                ],
                params: {
                  'isCreated': false,
                },
              ),
          headerTitle: 'Añadir tarjeta'),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: _buttonSave(),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: false,
                  obscureCardCvv: false,
                  labelCardHolder: 'Nombre y apellido',
                  labelExpiredDate: 'MM/AA',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: false,
                        obscureNumber: false,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: DBColors.GREEN,
                        textColor: DBColors.BLACK,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GREEN,
                            ),
                          ),
                          labelText: 'Número de tarjeta',
                          labelStyle: labelStyle,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CameraIcon(height: 24.0, width: 24.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GRAY_2,
                            ),
                          ),
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GREEN,
                            ),
                          ),
                          labelText: 'Nombre y apellido',
                          labelStyle: labelStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GRAY_2,
                            ),
                          ),
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GREEN,
                            ),
                          ),
                          labelText: 'MM/AA',
                          labelStyle: labelStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GRAY_2,
                            ),
                          ),
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GREEN,
                            ),
                          ),
                          labelText: 'CVV',
                          labelStyle: labelStyle,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: HintIcon(height: 24.0, width: 24.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: DBColors.GRAY_2,
                            ),
                          ),
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      //_buttonSave(),
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

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
      isActive = !isActive;
      creditCard = creditCardModel;
    });
  }

  _buttonSave() {
    return Container(
      padding: const EdgeInsets.only(
          top: 24.0, bottom: 24.0, left: 28.0, right: 28.0),
      child: GenericButtonOrange(
        text: 'GUARDAR TARJETA',
        disable: false,
        action: () {
          if (formKey.currentState.validate()) {
            //print('valid!');

            if (detectCCType(creditCard.cardNumber) ==
                    CreditCard.CardType.visa ||
                detectCCType(creditCard.cardNumber) ==
                    CreditCard.CardType.mastercard) {
              switch (detectCCType(creditCard.cardNumber)) {
                case CreditCard.CardType.visa:
                  creditCard.brand = '1';
                  break;
                case CreditCard.CardType.mastercard:
                  creditCard.brand = '2';
                  break;
                default:
                  creditCard.brand = null;
              }
              Routes.sailor.navigate(
                Routes.SPLASH_LOADING_ADD_CREDIT_CARD_SCREEN,
                navigationType: NavigationType.pushReplace,
                params: {
                  'creditCard': creditCard,
                },
              );
            } else {
              print('other brand');
              return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return PaymentMethodAlert();
                },
              );
            }
          } else {
            print('invalid!');
          }
        },
      ),
    );
  }
}
