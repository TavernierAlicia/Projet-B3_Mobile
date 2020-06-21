import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/order_requests.dart';
import 'package:projet_b3/utils.dart';
import 'package:intl/date_symbol_data_local.dart';

class PageOrder extends StatefulWidget {
  PageOrder({Key key, this.order, this.orderId}) : super(key: key);

  final Order   order ;
  final int     orderId ;

  @override
  _PageOrderState createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {

  Size              _screenSize ;
  BuildContext      _scaffoldContext ;

  Future<Order>     _orderDetailsFuture ;
  Order             _orderDetails ;

  @override
  void initState() {
    if (widget.orderId != null)
      _orderDetailsFuture = getOrderDetails(widget.orderId);
    else
      _orderDetailsFuture = getOrderDetails(widget.order.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;

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
      body: Builder(
        builder: (scaffoldContext) => _body(scaffoldContext),
      ),
    );
  }

  Widget    _body(BuildContext context) {

    _scaffoldContext = context ;

    return FutureBuilder(
      future: _orderDetailsFuture,
      builder: (context, snapshot) {
        return (
            (snapshot.hasData)
                ? _orderBody(snapshot.data as Order)
                : Center(
              child: CircularProgressIndicator(),
            )
        ) ;
      },
    );
  }

  Widget    _orderBody(Order order) {
    this._orderDetails = order ;
    return Center(
      child: Column(
        children: <Widget>[
          _header(),
          Padding(padding: EdgeInsets.only(top: 20, bottom: 20),),
          _orderDetailsSection(),
          Padding(padding: EdgeInsets.only(top: 20, bottom: 20),),
          _downloadReceiptButton(),
          Padding(padding: EdgeInsets.only(top: 20, bottom: 20),),
          _orderAgainButton(),
        ],
      ),
    );
  }

  Widget    _header() {

    String  establishmentAddress = "${_orderDetails.establishmentStreetNum} "
        + "${_orderDetails.establishmentStreetName}, "
        + "${_orderDetails.establishmentCity}" ;

    initializeDateFormatting("fr_FR");
    DateTime    parsedDate = DateTime.parse(_orderDetails.date);
    String      orderDate = DateFormat.yMMMd('fr_FR').format(DateTime.parse(_orderDetails.date));
    String      orderTime = "${parsedDate.hour}:${parsedDate.minute}";

    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20),),
        Text(
          "Command n ${_orderDetails.id}".toUpperCase(),
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5),),
        Text(
          "Le $orderDate a $orderTime".toUpperCase(),
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5),),
        Text(
          "a".toUpperCase(),
        ),
        Padding(padding: EdgeInsets.only(top: 5),),
        Text(
          _orderDetails.establishmentName.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5),),
        Text(
          establishmentAddress,
        ),
      ],
    );
  }

  Widget    _orderDetailsSection() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: Column(
        children: <Widget>[
          Text(
            "Commande".toUpperCase(),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 20),),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _orderDetails.orderItems.length,
            itemBuilder: (context, index) {
              OrderItem item = _orderDetails.orderItems[index] ;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${item.quantity} x ${item.name}",
                  ),
                  Text(
                    "${item.price * item.quantity} €",
                  ),
                ],
              );
            },
          ),
          Padding(padding: EdgeInsets.only(top: 20),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Pourboire"),
              Text("${_orderDetails.tip} €"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total :".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${_orderDetails.totalPrice} €",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 15),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Moyen de paiement :",
              ),
              Text(
                "Nature", // TODO
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget    _downloadReceiptButton() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: ButtonTheme(
        height: 50,
        child: FlatButton(
          color: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _screenSize.width / 10,
                height: _screenSize.width / 10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset("assets/download.png").image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text("Télécharger le reçu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onPressed: (() {
            showFeatureNotReadySnackBar(_scaffoldContext);
          }),
        ),
      ),
    );
  }

  Widget    _orderAgainButton() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: ButtonTheme(
        height: 50,
        child: FlatButton(
          color: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _screenSize.width / 10,
                height: _screenSize.width / 10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset("assets/circular_arrow.png").image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text("Commander à nouveau",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onPressed: (() {
            _orderAgain(_orderDetails);
          }),
        ),
      ),
    );
  }

  void    _orderAgain(Order order) {

    List<Product>    cartContent = [] ;

    order.orderItems.forEach((element) {
      print("in order items for loop ; element ${element.name} has quantity ${element.quantity}");
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
                order.establishmentStreetNum,
                order.establishmentStreetName,
                order.establishmentCity,
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