import 'package:flutter/material.dart';
import 'package:projet_b3/model/product.dart';

Widget productItem(context, Product item, {
  addToCart(Product item),
  removeFromCart(Product item)
}) {

  double _screenWidth = MediaQuery.of(context).size.width ;

  return StatefulBuilder(
    builder: (BuildContext itemContext, StateSetter itemSetState) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: _screenWidth / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3),),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3),),
                  Text(
                    item.price.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: _screenWidth / 2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      removeFromCart(item);
                      if (item.quantity > 0)
                        itemSetState(() => item.quantity--);
                    }),
                    child: Image.asset("assets/remove.png"),
                  ),
                  Text(
                    item.quantity.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      itemSetState(() {
                        item.quantity++;
                        addToCart(item);
                      }) ;
                    }),
                    child: Image.asset("assets/add.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}