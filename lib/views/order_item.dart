import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_b3/model/order.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget orderItem(context, Order order) {

  double _screenWidth = MediaQuery.of(context).size.width ;
  initializeDateFormatting("fr_FR");

  return Padding(
    padding: EdgeInsets.only(left: 15, top: 15, right: 15),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: _screenWidth / 4,
                  height: _screenWidth / 4,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(order.bar.imageUrl)
                      )
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    order.bar.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd('fr_FR').format(order.dateTime),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),
                  Text(
                    _createProductsList(order),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
          InkWell(
            onTap: (() {
              /// TODO
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Feature not implemented yet."),
              ));
            }),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child:  Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Icon(
                      /// TODO : Set the right icon
                      Icons.sync,
                      color: Colors.white,
                    ),
                    Text(
                      "Commander a nouveau",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ),
  );
}

/// No need to create a nested ListView inside each item that would contain
/// the products list, it would be a waste of resources (memory).
/// Instead, we create a static string containing the quantity and the product
/// name on each line.
String  _createProductsList(Order order) {
  String result = "";

  order.products.forEach((orderItem) {
    if (result.isNotEmpty)
      result += ",\n";
    result += "${orderItem.quantity} ${orderItem.name}";
  });
  return (result);
}