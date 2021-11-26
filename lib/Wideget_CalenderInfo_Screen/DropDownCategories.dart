/* import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../utilProperties.dart';

class DropDownCategory extends StatefulWidget {
  final Function? setCategory;

  const DropDownCategory({Key? key, this.setCategory}) : super(key: key);

  @override
  _DropDownCategoryState createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  late String _myCategoria;

  @override
  Widget build(BuildContext context) {
    @override
    // ignore: unused_element
    void initState() {
      super.initState();
      _myCategoria = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropDownFormField(
            filled: false,
            titleText: " ",
            hintText: 'Selecciona una categoria',
            value: _myCategoria,
            onSaved: (value) {
              setState(() {
                _myCategoria = value;
                widget.setCategory(value);
              });
            },
            onChanged: (value) {
              setState(() {
                _myCategoria = value;
                widget.setCategory(value);
              });
            },
            dataSource: category
                .map((e) => {
                      "display": e,
                      "value": e,
                    })
                .toList(),
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ),
    );
  }
}
 */