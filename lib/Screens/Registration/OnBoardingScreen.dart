import 'package:debarrioapp/widgets/components/generics/button_orange.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;
import 'package:debarrioapp/constants/text_style.dart' as DBStyles;

import 'phonenumber.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  TextStyle titleStyle = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_H1,
    DBStyles.FONT_HEIGHT_H1,
    0,
    DBStyles.FONT_WEIGHT_BOLD,
  );

  TextStyle descriptionStyle = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_H3,
    DBStyles.FONT_HEIGHT_H3,
    0,
    DBStyles.FONT_WEIGHT_REGULAR,
  );

  TextStyle _descriptionStyle = DBStyles.getStyle(
    DBStyles.WHITE,
    DBStyles.FONT_SYZE_H3,
    DBStyles.FONT_HEIGHT_H3,
    0,
    DBStyles.FONT_WEIGHT_SEMI_BOLD,
  );

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "¿Con deseos de \n comer algo o cocinar \n para tu gente?",
        marginTitle: EdgeInsets.only(top: 175.0),
        maxLineTitle: 3,
        styleTitle: titleStyle,
        description: "Conéctate con las personas\nde tu comunidad cercana.",
        marginDescription: EdgeInsets.only(top: 40.0),
        maxLineTextDescription: 2,
        styleDescription: descriptionStyle,
        //backgroundColor: Colors.amber,
        backgroundImageFit: BoxFit.cover,
        backgroundImage: 'assets/images/firstslide.png',
        backgroundOpacity: 0.7,
        backgroundOpacityColor: DBColors.BLACK,
      ),
    );
    slides.add(
      new Slide(
        title: "\n\nGana un dinero \nextra con tu arte \nculinario",
        maxLineTitle: 5,
        styleTitle: titleStyle,
        description:
            "Cocina tus platos preferidos y \nponlos a la venta en pocos \nsegundos.",
        marginDescription: EdgeInsets.only(top: 0.0),
        maxLineTextDescription: 3,
        styleDescription: descriptionStyle,
        backgroundColor: Colors.amber,
        backgroundImageFit: BoxFit.cover,
        backgroundImage: 'assets/images/secondslide.png',
        backgroundOpacity: 0.7,
        backgroundOpacityColor: Colors.grey[900],
      ),
    );
    slides.add(
      new Slide(
        title: "\n\nTu seguridad es\nimportante para\nnosotros",
        maxLineTitle: 5,
        styleTitle: titleStyle,
        widgetDescription: startedButton(),
        marginDescription: EdgeInsets.only(top: 0.0),
        maxLineTextDescription: 4,
        centerWidget: descriptionOnBoarding(),
        //styleDescription: descriptionStyle,
        backgroundColor: Colors.amber,
        backgroundImageFit: BoxFit.cover,
        backgroundImage: 'assets/images/finalslide.png',
        backgroundOpacity: 0.7,
        backgroundOpacityColor: Colors.grey[900],
      ),
    );
  }

  Widget renderSkipBtn() {
    return TextButton(
      child: Text(
        "Saltar",
        style: TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          padding: EdgeInsets.only(right: 10.0)),
      //color: Colors.transparent,
      onPressed: () => this.onDonePress(),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => PhoneNumScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            "assets/images/header_logo.svg",
            fit: BoxFit.cover,
            height: 25.0,
          ),
          //title: Text('Esto es una pruba'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            renderSkipBtn(),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          IntroSlider(
            slides: this.slides,
            colorActiveDot: Colors.green,
            colorDot: Colors.white,
            showNextBtn: false,
            showSkipBtn: false,
            hideStatusBar: true,
            showDoneBtn: false,
            isScrollable: true,
            sizeDot: 16,
            typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
          ),
          // Positioned(
          //   bottom: 32,
          //   left: 32,
          //   right: 32,
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 70,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.rectangle,
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       child: RaisedButton(
          //         elevation: 0.0,
          //         color: HexColor('E84A31'),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //         onPressed: onDonePress,
          //         child: Text(
          //           String.fromCharCode($iexcl) + "COMENCEMOS!",
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget descriptionOnBoarding() {
    return Padding(
      padding: EdgeInsets.only(),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'En ', style: descriptionStyle),
              TextSpan(text: 'De Barrio ', style: _descriptionStyle),
              TextSpan(text: 'nos\n', style: descriptionStyle),
              TextSpan(
                text:
                    'preocupamos de cuidar los\nestándares de calidad y\nsalubridad en tus compras.',
                style: descriptionStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget startedButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0, left: 48.0, right: 48.0),
      child: Center(
        child: GenericButtonOrange(
          text: '¡COMENCEMOS!',
          disable: false,
          action: () => onDonePress(),
          height: 56.0,
        ),
      ),
    );
  }
}
