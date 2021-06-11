import 'package:flutter/material.dart';
import 'package:debarrioapp/widgets/components/icons/radio_active.dart';
import 'package:debarrioapp/widgets/components/icons/cross.dart';

import 'package:debarrioapp/constants/colors.dart' as DBColors;

import 'payment_method_style.dart';

class AddNotify extends StatefulWidget {
  const AddNotify({
    Key key,
    @required this.isCreated,
  }) : super(key: key);

  final bool isCreated;

  @override
  _AddNotifyState createState() => _AddNotifyState();
}

class _AddNotifyState extends State<AddNotify> {
  double opacity = 1;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 600),
      opacity: opacity,
      child: InkWell(
        onTap: () {
          setState(() {
            opacity = (opacity == 1) ? 0 : 1;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: DBColors.GREEN_LIGHT,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, bottom: 14.0, left: 16.0),
                    child: RadioActiveIcon(
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 12.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '¡Listo! ',
                            style: notifyTitleStyle,
                          ),
                          TextSpan(
                            text: 'Agregaste la tarjeta',
                            style: notifySubTitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                child: CrossIcon(
                  height: 16.0,
                  width: 16.0,
                  color: DBColors.GREEN,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
