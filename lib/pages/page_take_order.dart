import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/order_requests.dart';

class   PageTakeOrder extends StatefulWidget {
  PageTakeOrder({
        Key key,
        this.bar,
        this.cartContent,
        this.arrivingIn,
        this.paymentMethod,
      }) : super(key: key);

  final     Bar           bar ;
  final     List<Product> cartContent ;
  final     int           arrivingIn ;
  final     PaymentMethod paymentMethod ;

  @override
  _PageTakeOrderState createState() => _PageTakeOrderState();
}

class _PageTakeOrderState extends State<PageTakeOrder> {

  double            _screenWidth = 0 ;
  double            _screenHeight = 0 ;
  Future<String>    _orderStatus ;

  @override
  void initState() {
    _orderStatus = takeOrder(
      widget.bar,
      widget.cartContent,
      widget.arrivingIn,
      widget.paymentMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _screenWidth = MediaQuery.of(context).size.width ;
    _screenHeight = MediaQuery.of(context).size.height ;

    return Scaffold(
      body: FutureBuilder(
        future: _orderStatus,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return _orderCompleteLayout();
          } else {
            return _loadingLayout();
          }
        },
      ),
    );
  }

  Widget    _orderCompleteLayout() {
    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Colors.deepOrange,
      child: (Text("OK")),
    );
  }

  Widget    _loadingLayout() {
    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Colors.deepOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 75,
            height: 75,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(15),),
          Text(
            "Veuillez patienter".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.all(15),),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Text(
                "Nous sommes en train de procéder à la vérification de votre paiement.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

}