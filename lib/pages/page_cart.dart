import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_take_order.dart';
import 'package:projet_b3/views/bar_header.dart';

class PageCart extends StatefulWidget {
  PageCart({Key key, this.cartContent, this.bar}) : super(key: key);

  final List<Product> cartContent ;
  final Bar           bar ;

  @override
  _PageCartState createState() => _PageCartState();
}

enum UserPosition {
  onTheSpot,
  onMyWay,
}

enum PaymentMethod {
  cb,
  payPal,
  cash,
}

class _PageCartState extends State<PageCart> {

  double          _screenWidth = 0 ;

  UserPosition    _currentUserPosition = UserPosition.onTheSpot ;
  PaymentMethod   _selectedPaymentMethod = PaymentMethod.cash ;
  int             _selectedArrivingIn = 0 ;
  int             _selectedTip = 0 ;

  static const String DEFAULT_ARRIVING_IN_TEXT = "J'arrive dans quelques minutes" ;

  bool            _showTimeList = false ;
  var             _arrivingInList = [10, 15, 20, 25, 30] ;
  var             _arrivingInText = DEFAULT_ARRIVING_IN_TEXT ;

  @override
  Widget build(BuildContext context) {

    _screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Mon panier".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.deepOrange
        ),
      ),
      body: _body(),
      bottomSheet: InkWell(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageTakeOrder(
                bar: widget.bar,
                cartContent: widget.cartContent,
                arrivingIn: _selectedArrivingIn,
                tip: _selectedTip,
                paymentMethod: _selectedPaymentMethod,
              ),
            ),
          );
        }),
        child: Container(
          width: _screenWidth,
          color: Colors.deepOrange,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Valider",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget    _body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          barHeader(widget.bar, _screenWidth),
          _lineSeparator(),
          _orderSummary(),
          _lineSeparator(),
          (_selectedTip != 0) ? _displaySelectedTip() : Container(),
          _displayTotal(),
          Padding(padding: EdgeInsets.all(10),),
          _userPosition(),
          Padding(padding: EdgeInsets.all(10),),
          _tips(),
          Padding(padding: EdgeInsets.all(10),),
          _paymentMethod(),
          Padding(padding: EdgeInsets.all(40),)
        ],
      ),
    );
  }

  Widget    _paymentMethod() {
    return Column(
      children: <Widget>[
        Text("Choisissez un autre moyen de paiement"),
        Padding(padding: EdgeInsets.all(10),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _paymentMethodItem(PaymentMethod.cb, "assets/cb.png"),
            _paymentMethodItem(PaymentMethod.payPal, "assets/paypal.png"),
            _paymentMethodItem(PaymentMethod.cash, "assets/money.png"),
          ],
        ),
      ],
    );
  }

  Widget    _paymentMethodItem(PaymentMethod paymentMethod, String imagePath) {
    return GestureDetector(
      onTap: (() {
        setState(() {
          _selectedPaymentMethod = paymentMethod ;
        });
      }),
      child: Container(
        decoration: (_selectedPaymentMethod == paymentMethod) ? BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.deepOrange,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ) : null,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }

  Widget    _tips() {

    return Container(
        color: Colors.deepOrangeAccent.withOpacity(0.4),
        width: _screenWidth,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text("Je souhaite laisser un pourboire"),
              Padding(padding: EdgeInsets.all(10),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _tipItem(1),
                  _tipItem(2),
                  _tipItem(3),
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget    _tipItem(int tipValue) {
    return InkWell(
      onTap: (() {
        setState(() {
          if (tipValue != _selectedTip)
            _selectedTip = tipValue ;
          else
            _selectedTip = 0 ;
        });
      }),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (tipValue == _selectedTip) ? Colors.white : Colors.deepOrange,
          border: Border.all(color: Colors.deepOrange),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "$tipValue €",
            style: TextStyle(
              color: (tipValue == _selectedTip) ? Colors.deepOrange : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  Widget    _userPosition() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (() {
              setState(() {
                _currentUserPosition = UserPosition.onTheSpot ;
                _showTimeList = false ;
                _arrivingInText = DEFAULT_ARRIVING_IN_TEXT ;
                _selectedArrivingIn = 0 ;
              });
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  groupValue: _currentUserPosition.index,
                  value: UserPosition.onTheSpot.index,
                  onChanged: ((newValue){
                    setState(() {});
                  }),
                ),
                Text(
                  "Je suis sur place",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                _currentUserPosition = UserPosition.onMyWay ;
                _showTimeList = true ;
              });
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  groupValue: _currentUserPosition.index,
                  value: UserPosition.onMyWay.index,
                  onChanged: ((newValue){
                    setState(() {});
                  }),
                ),
                Text(
                  _arrivingInText,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: (_showTimeList)
                ? Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1,
                  )
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Combien de minutes"),
                ),
                onChanged: ((newValue) {
                  setState(() {
                    _arrivingInText = "J'arrive dans $newValue minutes";
                    _showTimeList = false ;
                    _selectedArrivingIn = newValue ;
                  });
                }),
                items: _arrivingInList.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text("$value minutes"),
                  );
                }).toList(),
              ),
            )
                : null,
          ),
        ],
      ),
    );
  }

  Widget    _orderSummary() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Wrap(
        children: <Widget>[
          Text(
            "Votre commande",
            style: TextStyle(
                fontSize: 15
            ),
          ),
          Padding(padding: EdgeInsets.all(15),),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cartContent.length,
            itemBuilder: (context, index) {
              Product   _item = widget.cartContent[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("${_item.quantity} x ${_item.name}",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  Text("${_item.price} €",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget    _displaySelectedTip() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Pourboire",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            "$_selectedTip €",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget    _displayTotal() {

    double    _totalPrice = 0 ;

    widget.cartContent.forEach((element) {
      _totalPrice += (element.price * element.quantity);
    });

    _totalPrice += _selectedTip ;

    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$_totalPrice €",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget    _lineSeparator() {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        height: 0.5,
        width: _screenWidth,
        color: Colors.deepOrange,
      ),
    );
  }

}
