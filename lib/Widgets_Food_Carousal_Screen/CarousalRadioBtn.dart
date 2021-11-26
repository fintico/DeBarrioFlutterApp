/* import 'package:flutter/material.dart';

class RadioCarousal extends StatefulWidget {
  final Function? setOrderType;

  const RadioCarousal({Key? key, this.setOrderType}) : super(key: key);
  @override
  _RadioCarousalState createState() => _RadioCarousalState();
}

class _RadioCarousalState extends State<RadioCarousal> {
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int? val) {
    widget.setOrderType!(val);
    setState(() {
      selectedRadio = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.03,
      child: Row(
        children: [
          new Radio(
            onChanged: (value) => {setSelectedRadio(value)},
            value: 0,
            groupValue: selectedRadio,
            activeColor: Colors.green,
          ),
          new Text(
            'Delivery',
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(
            activeColor: Colors.green,
            onChanged: (value) => {setSelectedRadio(value)},
            value: 1,
            groupValue: selectedRadio,
          ),
          new Text(
            'Recojo',
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
 */