import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';

Widget barHeader(Bar bar, double screenWidth) {
  return Row(
    children: <Widget>[
      Container(
        width: screenWidth / 3,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.network("https://s1.qwant.com/thumbr/0x380/3/9/60c4de7be57ee1b7d24d07dde941c3027588bc313699cba9ef9ef8fb6c7fda/1280px-Hard_Rock_Cafe_Logo.svg.png?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F2%2F2c%2FHard_Rock_Cafe_Logo.svg%2F1280px-Hard_Rock_Cafe_Logo.svg.png&q=0&b=1&p=0&a=1").image,
            )
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            bar.name.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Bar category" + " - " + "Bar address",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Opening hours" + " - " + "01.12.12.12.12",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Happy Hour de 20h a 23h",
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ],
  );
}