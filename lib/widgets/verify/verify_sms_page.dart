import 'package:debarrioapp/utils/screen_size_reducers.dart';
import 'package:debarrioapp/utils/user_app_data.dart';
import 'package:debarrioapp/routers/router.dart';
import 'package:debarrioapp/widgets/components/generics/app_bar_opt_one.dart';
import 'package:debarrioapp/widgets/verify/verify_sms_args.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

class VerifySMSPage extends StatefulWidget {
  final VerifySMSPageArgs? args;
  VerifySMSPage({Key? key, this.args}) : super(key: key);

  @override
  _VerifySMSPageState createState() => _VerifySMSPageState();
}

class _VerifySMSPageState extends State<VerifySMSPage> {
  final verificationCode = TextEditingController();

  TextStyle titleStyle = DBStyles.getStyle(
    DBStyles.GRAY_1,
    DBStyles.FONT_SYZE_H2,
    DBStyles.FONT_HEIGHT_H2,
    0,
    DBStyles.FONT_WEIGHT_BOLD,
  );

  TextStyle subtextStyle = DBStyles.getStyle(
    DBStyles.BLACK,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle richSubtextStyle = DBStyles.getStyle(
    DBStyles.BLACK,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_SEMI_BOLD,
  );

  TextStyle codeTextStyle = DBStyles.getStyle(
    DBStyles.GRAY_2,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle errorTextStyle = DBStyles.getStyle(
    DBStyles.RED,
    DBStyles.FONT_SYZE_M,
    DBStyles.FONT_HEIGHT_M,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle otpTextStyle = DBStyles.getStyle(
    DBStyles.BLACK,
    DBStyles.FONT_SYZE_H3,
    DBStyles.FONT_HEIGHT_H3,
    0,
    DBStyles.FONT_WEIGHT_BOLD,
  );

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      child: AppBarOptionOne(
        leftIconAction: () => {},
      ),
      preferredSize: Size.fromHeight(56.0),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context, dividedBy: 5.0),
              ),
              titleDescription(),
              SizedBox(
                height: screenHeight(context, dividedBy: 40.0),
              ),
              subTitleDescription(),
              SizedBox(
                height: screenHeight(context, dividedBy: 30.0),
              ),
              pinFieldAutoFill(),
              SizedBox(
                height: screenHeight(context, dividedBy: 50.0),
              ),
              sendNewCode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        'Verificación',
        style: titleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget subTitleDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(text: 'Ingresa el ', style: subtextStyle),
            TextSpan(text: 'código de verificación ', style: richSubtextStyle),
            TextSpan(
                text: 'SMS para\n validar tu número de celular.',
                style: subtextStyle),
          ],
        ),
      ),
    );
  }

  Widget pinFieldAutoFill() {
    //var stateColor = DBColors.GRAY_2;
    SmsAutoFill().listenForCode;
    return Container(
      height: 86,
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Container(
            height: 54,
            child: PinFieldAutoFill(
              codeLength: 6,
              currentCode: userAppData.verificationCode,
              controller: this.verificationCode,
              decoration: BoxLooseDecoration(
                radius: Radius.circular(8),
                strokeColorBuilder: FixedColorBuilder(
                    widget.args!.error! ? DBColors.RED : DBColors.GREEN),
                strokeWidth: 1,
                textStyle: otpTextStyle,
              ),
              onCodeChanged: (val) {
                print(val);
                userAppData.verificationCode = val;
                if (!widget.args!.error! &&
                    userAppData.verificationCode!.length == 6) {
                  print('codigo enviado');
                  Routes.sailor.navigate(
                    Routes.SPLASH_LOADING_VERIFICATION_SMS_SCREEN,
                    navigationType: NavigationType.pushReplace,
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 20,
            child: widget.args!.error!
                ? Text(
                    'Código inválido',
                    style: errorTextStyle,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'Ingresa el código',
                    style: codeTextStyle,
                    textAlign: TextAlign.center,
                  ),
          )
        ],
      ),
    );
  }

  Widget sendNewCode() {
    return Container(
      child: GestureDetector(
        onTap: () {
          print(userAppData.verificationCode);
        },
        child: Text("Enviar nuevo código",
            style: DBStyles.getStyle(
              widget.args!.error! ? DBStyles.RED : DBStyles.GREEN,
              DBStyles.FONT_SYZE_M,
              DBStyles.FONT_HEIGHT_M,
              0,
              DBStyles.FONT_WEIGHT_SEMI_BOLD,
            ),
            textAlign: TextAlign.center),
      ),
    );
  }
}
