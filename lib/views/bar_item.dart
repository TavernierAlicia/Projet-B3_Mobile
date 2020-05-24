import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/pages/page_bar.dart';

Widget  barItem(context, Bar item) {

  var _width = MediaQuery.of(context).size.width ;

  return new InkWell(
    onTap: (() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageBar(bar: item))
      );
    }),
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.network(
                item.imageUrl,
                width: _width / 3,
              ),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(item.description),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}