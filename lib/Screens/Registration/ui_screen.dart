import 'package:debarrioapp/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UiScreen extends StatelessWidget {
  final String? uid;
  const UiScreen({Key? key, this.uid}) : super(key: key);

  void _loginUser(BuildContext context, String? uid) {
    Provider.of<RegisterProvider>(context, listen: false).loginUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    _loginUser(context, uid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Uid'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(uid ?? '-'),
      ),
    );
  }
}
