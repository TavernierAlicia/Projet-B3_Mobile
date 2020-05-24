import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/views/order_item.dart';

class PageOrders extends StatefulWidget {
  PageOrders({Key key}) : super(key: key);

  @override
  _PageOrdersState createState() => _PageOrdersState();
}

class _PageOrdersState extends State<PageOrders> {

  var _ordersList = [
    Order(
      Bar(
        "Gatsby Bar",
        "",
        4,
        "https://s1.qwant.com/thumbr/0x380/1/2/2a39f1f558f2cbbec11a08e43493bde861d612add6be643dbc5ad6fe0b16fc/BDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg?u=https%3A%2F%2Fimages.bwwstatic.com%2Fcolumnpic6%2FBDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg&q=0&b=1&p=0&a=1",
        LatLng(12, 12),
      ),
      DateTime.now(),
      [
        Product("Biere blonde pression", "", 7, true),
        Product("Verre vin rose", "", 5.3, true),
      ],
      12.3
    ),
    Order(
        Bar(
          "Dance Again Bar",
          "",
          4,
          "https://s1.qwant.com/thumbr/0x380/b/7/96dc30e4a2364bcfad819f8db4940ae8529b241d22bf13e23676de6d981c00/5c7059b1b52c2.image.jpg?u=https%3A%2F%2Fbloximages.newyork1.vip.townnews.com%2Frichmond.com%2Fcontent%2Ftncms%2Fassets%2Fv3%2Feditorial%2F3%2Fcf%2F3cf70200-ddaf-55ce-82e8-52f880415809%2F5c7059b1b52c2.image.jpg&q=0&b=1&p=0&a=1",
          LatLng(12, 12),
        ),
        DateTime.now(),
        [
          Product("Biere blonde pression", "", 7, true),
          Product("Verre vin rose", "", 5.3, true),
        ],
        12.3
    ),
    Order(
        Bar(
          "Gatsby Bar",
          "",
          4,
          "https://s1.qwant.com/thumbr/0x380/1/2/2a39f1f558f2cbbec11a08e43493bde861d612add6be643dbc5ad6fe0b16fc/BDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg?u=https%3A%2F%2Fimages.bwwstatic.com%2Fcolumnpic6%2FBDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg&q=0&b=1&p=0&a=1",
          LatLng(12, 12),
        ),
        DateTime.now(),
        [
          Product("Biere blonde pression", "", 7, true),
          Product("Verre vin rose", "", 5.3, true),
        ],
        12.3
    ),
    Order(
        Bar(
          "Dance Again Bar",
          "",
          4,
          "https://s1.qwant.com/thumbr/0x380/b/7/96dc30e4a2364bcfad819f8db4940ae8529b241d22bf13e23676de6d981c00/5c7059b1b52c2.image.jpg?u=https%3A%2F%2Fbloximages.newyork1.vip.townnews.com%2Frichmond.com%2Fcontent%2Ftncms%2Fassets%2Fv3%2Feditorial%2F3%2Fcf%2F3cf70200-ddaf-55ce-82e8-52f880415809%2F5c7059b1b52c2.image.jpg&q=0&b=1&p=0&a=1",
          LatLng(12, 12),
        ),
        DateTime.now(),
        [
          Product("Biere blonde pression", "", 7, true),
          Product("Verre vin rose", "", 5.3, true),
        ],
        12.3
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mes commandes"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _currentOrder(),
          Text(
            "Anciennes commandes",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
          ),
          _orders(),
        ],
      ),
    );
  }

  Widget _orders() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _ordersList.length,
      itemBuilder: (context, i) {
        return orderItem(context, _ordersList[i]);
      },
    );
  }

  Widget _currentOrder() {
    return Text("");
  }
}