import 'package:flutter/material.dart';

class BottomBarCalenderInfo extends StatefulWidget {
  final Function setPostedDish;

  const BottomBarCalenderInfo({Key key, this.setPostedDish}) : super(key: key);
  @override
  _BottomBarCalenderInfoState createState() => _BottomBarCalenderInfoState();
}

class _BottomBarCalenderInfoState extends State<BottomBarCalenderInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                        child: Text("Cacelor"),
                        color: Colors.grey[300],
                        elevation: 0.0,
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
                          widget.setPostedDish();
                        },
                        child: Text("Confirmar venta"),
                        elevation: 0.0,
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
