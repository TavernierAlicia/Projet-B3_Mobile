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
    this.tip,
    this.paymentMethod,
  }) : super(key: key);

  final     Bar           bar ;
  final     List<Product> cartContent ;
  final     int           arrivingIn ;
  final     int           tip ;
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
      widget.bar.id,
      widget.cartContent,
      widget.arrivingIn,
      widget.tip,
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
          // TODO : else if payment failed
        },
      ),
    );
  }

  Widget    _orderCompleteLayout() {
    return Container(
      width: _screenWidth,
      height: _screenHeight,
      color: Colors.deepOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset("assets/circle.png"),
              Image.asset("assets/valid.png"),
            ],
          ),
          Padding(padding: EdgeInsets.all(15),),
          Text(
            "Paiement validé".toUpperCase(),
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
                "L'achat a été réalisé avec succès. Veuillez consulter votre commande.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20),),
          InkWell(
            onTap: (() {
              // TODO
            }),
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.none
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "Voir la commande",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10),),
          InkWell(
            onTap: (() {
              // TODO
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
            child: Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.none
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "Retour à l'accueil",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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