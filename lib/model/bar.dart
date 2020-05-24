import 'package:latlong/latlong.dart';

class Bar {

  Bar(String name, String description, int note, String imageUrl,
      LatLng coordinates) {
    this.name = name ;
    this.description = description ;
    this.note = note ;
    this.imageUrl = imageUrl ;
    this.coordinates = coordinates ;
  }

  String  name ;
  String  description ;
  int     note ;
  String  imageUrl ;
  LatLng  coordinates ;
}