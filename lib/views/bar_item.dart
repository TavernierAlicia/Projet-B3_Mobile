import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/pages/page_bar.dart';

Widget  barItem(context, Bar bar) {

  var _screenWidth = MediaQuery.of(context).size.width ;

  return new Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      width: _screenWidth / 1.3,
      child: InkWell(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageBar(bar: bar))
          );
        }),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        image: Image.network(bar.imageUrl).image,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        bar.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        bar.subtype + " - " + "Bar address",  // TODO
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ouvert jusqu'a 23h59" + " - " + "01.12.12.12.12",  // TODO
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Happy Hour de 20h a 23h",  // TODO
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}