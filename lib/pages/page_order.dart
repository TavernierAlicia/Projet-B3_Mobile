import 'package:flutter/material.dart';
import 'package:projet_b3/model/order.dart';

class PageOrder extends StatefulWidget {
  PageOrder({Key key, this.order}) : super(key: key);

  final Order order ;

  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Ma commande".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: _body(),
    );
  }

  Widget    _body() {
    return Column();
  }
}