import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';

Widget barHeader(Bar bar, double screenWidth) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: screenWidth / 4,
          height: screenWidth / 4,
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
      ),
    ],
  );
}