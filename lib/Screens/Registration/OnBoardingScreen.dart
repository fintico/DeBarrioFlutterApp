import 'package:charcode/charcode.dart';
import 'package:da_brello_ui/Services/FirebaseAuthService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'phonenumber.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  TextStyle titleStyle = GoogleFonts.openSans(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: Colors.white);

  TextStyle descriptionStyle = GoogleFonts.openSans(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: Colors.white);

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
          title:
              "\n\n¿Con deseos de \n corner algo o cocinar \n para tu gente?",
          maxLineTitle: 5,
          styleTitle: titleStyle,
          description: "Conéctate con las personas\nde to comunidad cercana.",
          marginDescription: EdgeInsets.only(top: 0.0),
          maxLineTextDescription: 2,
          styleDescription: descriptionStyle,
          backgroundColor: Colors.amber,
          backgroundImageFit: BoxFit.cover,
          backgroundImage: 'assets/images/firstslide.png'),
    );
    slides.add(
      new Slide(
          title: "\n\nGana un dinero \nextra con to arte \nculinario",
          maxLineTitle: 5,
          styleTitle: titleStyle,
          description:
              "Coma tus platos preferidos y \nponlos a la yenta en pocos \nsegundos",
          marginDescription: EdgeInsets.only(top: 0.0),
          maxLineTextDescription: 2,
          styleDescription: descriptionStyle,
          backgroundColor: Colors.amber,
          backgroundImageFit: BoxFit.cover,
          backgroundImage: 'assets/images/secondslide.png'),
    );
    slides.add(
      new Slide(
          title: "\n\nTu seguridad es\nimportante para\nnosotros",
          maxLineTitle: 5,
          styleTitle: titleStyle,
          description:
              "En De Barrio nos\npreocupamos de cuidar los\nestandares de calidad y\nsalubridad en tus compras.",
          marginDescription: EdgeInsets.only(top: 0.0),
          maxLineTextDescription: 2,
          styleDescription: descriptionStyle,
          backgroundColor: Colors.amber,
          backgroundImageFit: BoxFit.cover,
          backgroundImage: 'assets/images/finalslide.png'),
    );
  }

  Widget renderSkipBtn() {
    return FlatButton(
      child: Text(
        "Saltar",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.transparent,
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
          title: Image(
            image: AssetImage("assets/images/Logo.png"),
          ),
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
            isShowNextBtn: false,
            isShowSkipBtn: false,
            shouldHideStatusBar: true,
            isShowDoneBtn: false,
            sizeDot: 10,
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
}
