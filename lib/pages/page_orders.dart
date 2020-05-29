import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/order_requests.dart';
import 'package:projet_b3/views/order_item.dart';

class PageOrders extends StatefulWidget {
  PageOrders({Key key}) : super(key: key);

  @override
  _PageOrdersState createState() => _PageOrdersState();
}

class _PageOrdersState extends State<PageOrders> {

  Future<List<Order>>     _ordersList ;

  @override
  void initState() {
    _ordersList = getOrdersHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Mes commandes".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: _ordersList,
      builder: (context, snapshot) {
        return (snapshot.data != null) ? SingleChildScrollView(
          child: _orders(snapshot.data as List<Order>),
        ) : Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _orders(List<Order> orders) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, i) {
        return orderItem(context, orders[i], orderAgain: _orderAgain);
      },
    );
  }

  void    _orderAgain(Order order) {

    List<Product>    cartContent = [] ;

    order.orderItems.forEach((element) {
      cartContent.add(Product(
        element.itemId,
        element.name,
        "",
        element.price,
        0,
        0,
        "",
        quantity: element.quantity,
      )) ;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PageCart(
            cartContent: cartContent,
            bar: Bar(
                order.establishmentId,
                order.establishmentName,
                "",
                "",
                "",
                0,
                0,
                order.pictureUrl,
                "",
                0,
                "",
                "",
                "",
                "",
                ""
            ),
          );
        },
      ),
    );
  }
}