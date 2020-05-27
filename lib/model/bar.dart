import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bar {

  Bar(int id, String name, String description, String type, String subtype,
      double lat, double long, String imageUrl, String date, int streetNum,
      String streetName, String city, String zip, String happyHourStart,
      String happyHourEnd) {
    print("In default constructor, name = $name");
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.type = type ;
    this.subtype = subtype ;
    this.coordinates = LatLng(lat, long) ;
    this.imageUrl = imageUrl ;
    this.date = date ;
    this.streetNum = streetNum ;
    this.streetName = streetName ;
    this.city = city ;
    this.zip = zip ;
    this.happyHourStart = happyHourStart ;
    this.happyHourEnd = happyHourEnd ;
  }

  factory Bar.fromJson(Map<String, dynamic> jsonMap) {
    print("IN FACTORY : $jsonMap");
    return Bar(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Description"],
      jsonMap["Type"],
      jsonMap["Subtype"],
      jsonMap["Lat"],
      jsonMap["Long"],
      jsonMap["Pic"],
      jsonMap["Date"],
      jsonMap["StreetNum"],
      jsonMap["StreetName"],
      jsonMap["City"],
      jsonMap["Zip"],
      jsonMap["Happy"],
      jsonMap["HappyEnd"],
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
  int     streetNum ;
  String  streetName ;
  String  city ;
  String  zip ;
  String  happyHourStart ;
  String  happyHourEnd ;
}