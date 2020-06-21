import 'package:flutter/material.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/requests/order_requests.dart';

class PageOrder extends StatefulWidget {
  PageOrder({Key key, this.order, this.orderId}) : super(key: key);

  final Order   order ;
  final int     orderId ;

  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {

  @override
  void initState() {
    if (widget.orderId != null) {
      // order = await getOrder(widget.orderId) ;
    }
    // print("In PageOrder initState ; ORDER ID = ${widget.orderId} ; ORDER = ${widget.order.id}");
    super.initState();
  }

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