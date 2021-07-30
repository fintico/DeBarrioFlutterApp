/* import 'package:debarrioapp/ModelClass/AdditionDishModel.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ServicesFire/FirebaseFireStoreService.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Adicionalas extends StatefulWidget {
  @override
  _AdicionalasState createState() => _AdicionalasState();
}

class _AdicionalasState extends State<Adicionalas> {
  PostedDish postedDish;
  AdditionDish additionDish = AdditionDish();
  bool freeValue = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    postedDish = Provider.of<PostedDish>(context, listen: false);
    //TODO: Do validations
    return Scaffold(
      backgroundColor: HexColor("#f2f2f2"),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    width: (MediaQuery.of(context).size.width),
                    child: Text("Agregar Adicionalas",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Divider(
                    thickness: 1,
                    endIndent: 100,
                    indent: 24.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    width: (MediaQuery.of(context).size.width),
                    child: Text("Anade complementos que combinen con tu pulao",
                        style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Adicional",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      onChanged: setAdditionDishName,
                      decoration: InputDecoration(
                        hintText: "Complemento",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    width: (MediaQuery.of(context).size.width),
                    child: Text(
                      "Adicional",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: TextField(
                      readOnly: freeValue,
                      keyboardType: TextInputType.number,
                      controller: controller,
                      onChanged: setAdditionDishPrice,
                      decoration: InputDecoration(
                        hintText: "S/0.00",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: CheckboxListTile(
                      title: Text("Crema huancaina"),
                      value: freeValue,
                      activeColor: Colors.green,
                      onChanged: (newValue) {
                        if (newValue) {
                          additionDish.price = '0';
                          controller.text = additionDish.price;
                        }
                        setState(() {
                          freeValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                              if (postedDish.additionDish == null)
                                postedDish.additionDish = [];
                              postedDish.additionDish.add(additionDish);
                              postedDish.notifyListeners();
                              DatabaseService().setPostedDishData(postedDish);
                              Navigator.pop(context, 'change');
                            },
                            child: Text("Agregor adicional"),
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
            ],
          )),
    );
  }

  void setAdditionDishName(String value) {
    additionDish.additionName = value;
  }

  void setAdditionDishPrice(String value) {
    if (!freeValue) {
      additionDish.price = value;
    }
  }
}
 */
