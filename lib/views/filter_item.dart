import 'package:flutter/material.dart';
import 'package:projet_b3/model/filter.dart';

Widget filterItem(Filter filter, bool isFilterSelected) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
        color: (isFilterSelected)
            ? Colors.green
            : Colors.deepOrange,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Center(
      child: Text(
        filter.name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}