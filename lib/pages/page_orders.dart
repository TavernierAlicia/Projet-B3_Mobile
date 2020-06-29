import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/pages/page_order.dart';
import 'package:projet_b3/requests/order_requests.dart';
import 'package:projet_b3/views/order_item.dart';

// TODO : RELOAD WHEN COMING BACK FROM ORDER AGAIN

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
        return (snapshot.data != null)
            ? _orders(snapshot.data as List<Order>)
            : Center(
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

    if (orders.length == 0) {
      return Center(
        child: Text(
            "Aucune commande pour l'instant !"
        ),
      );
    }

    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, i) {
          return orderItem(context, orders[i], orderAgain: _orderAgain,
            orderClicked: _orderClicked,);
        },
      ),
    );
  }

  /// Builds a new cart containing a [List] of [Product] items, and passes it to
  /// the [PageCart]. We also wait for the page to finish, as we want to reload
  /// the list of orders if the user confirms his command.
  void    _orderAgain(Order order) async {

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
    ).then((value) {
      setState(() {
        _ordersList = getOrdersHistory();
      });
    });
  }

  /// Triggered when the user clicks on an order, opens the [PageOrder].
  /// We also wait for the page to finish as we need to reload the list if the
  /// user used orderAgain feature.
  void    _orderClicked(Order order) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PageOrder(order: order)
        )
    ).then((value) {
      setState(() {
        _ordersList = getOrdersHistory();
      });
    });
  }
}