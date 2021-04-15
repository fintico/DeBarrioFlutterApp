import 'package:carousel_slider/carousel_slider.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/utilsFunctions.dart';
import 'package:flutter/material.dart';

class CarousalSliderWidget extends StatelessWidget {
  final List<PostedDish> currentPostedDish;
  final Function setIndex;

  const CarousalSliderWidget({Key key, this.currentPostedDish, this.setIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> imgList =
        currentPostedDish.map((e) => e.dishPictureURI).toList();
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        cZeroStr(item)
                            ? Image.network(item)
                            : Image.asset('assets/images/carouselfirst.png',
                                fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            ))
        .toList();
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      child: CarouselSlider(
        options: CarouselOptions(
          onPageChanged: checkInput,
          autoPlay: false,
          pageSnapping: true,
          enlargeCenterPage: true,
        ),
        items: imageSliders,
      ),
    );
  }

  checkInput(int index, CarouselPageChangedReason reason) {
    setIndex(index);
  }
}
