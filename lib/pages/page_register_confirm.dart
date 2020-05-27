import 'package:flutter/material.dart';

class PageRegisterConfirm extends StatefulWidget {
  PageRegisterConfirm({Key key}) : super(key: key);

  @override
  _PageRegisterConfirmState createState() => _PageRegisterConfirmState();
}

class _PageRegisterConfirmState extends State<PageRegisterConfirm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Column(
          children: <Widget>[
            Stack(),
            Text("Vous etes inscrit"),
          ],
        ),
      ),
    );
  }
}