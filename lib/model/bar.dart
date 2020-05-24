import 'dart:convert';

import 'package:latlong/latlong.dart';

class Bar {

  Bar(int id, String name, String description, String type, String subtype,
      double lat, double long, String imageUrl, String date) {
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.type = type ;
    this.subtype = subtype ;
    this.coordinates = LatLng(lat, long) ;
    this.imageUrl = imageUrl ;
    this.date = date ;
  }

  factory Bar.fromJson(Map<String, dynamic> jsonMap) {
    return Bar(
      jsonMap["id"],
      jsonMap["Name"],
      jsonMap["Description"],
      jsonMap["Type"],
      jsonMap["Subtype"],
      jsonMap["Lat"],
      jsonMap["Long"],
      jsonMap["Pic"],
      jsonMap["Date"],
    );
  }

  int     id ;
  String  name ;
  String  description ;
  String  type ;
  String  subtype ;
  LatLng  coordinates ;
  String  imageUrl ;
  String  date ;
}