import 'package:projet_b3/model/product.dart';

class BarInfo {

  BarInfo(int id, String name, String description, int favorites,
      int streetNumber, String streetName, String complement, String city,
      String zip, String type, String subtype, String imageUrl, String date,
      String open, String happyHourStart, String happyHourEnd,
      bool isFavorite, List<Product> products) {
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.favorites = favorites ;
    this.streetNumber = streetNumber ;
    this.streetName = streetName ;
    this.complement = complement ;
    this.city = city ;
    this.zip = zip ;
    this.type = type ;
    this.subtype = subtype ;
    this.imageUrl = imageUrl ;
    this.date = date ;
    this.open = open ;
    this.happyHourStart = happyHourStart ;
    this.happyHourEnd = happyHourEnd ;
    this.isFavorite = isFavorite ;
    this.products = products ;
  }

  factory BarInfo.fromJson(Map<String, dynamic> json) {

    print("In factory : $json");
    print("BAR DETAILS = ${json["BarDetails"]}");
    print("ITEMS = ${json["Items"]}");

    List<Product> _products = [] ;

    var jsonMap = json["BarDetails"] ;
    var jsonProducts = json["Items"] ;

    _products = jsonProducts.map<Product>((json) => Product.fromJson(json)) ;

    return BarInfo(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Description"],
      jsonMap["Favs"],
      jsonMap["Street_num"],
      jsonMap["Street_name"],
      jsonMap["Complement"],
      jsonMap["City"],
      jsonMap["Zip"],
      jsonMap["Type"],
      jsonMap["Subtype"],
      jsonMap["Pic"],
      jsonMap["Date"],
      jsonMap["Open"],
      jsonMap["HH"],
      jsonMap["HHEnd"],
      jsonMap["IsFav"],
      _products,
    );
  }

  int             id ;
  String          name ;
  String          description ;
  int             favorites ;
  int             streetNumber ;
  String          streetName ;
  String          complement ;
  String          city ;
  String          zip ;
  String          type ;
  String          subtype ;
  String          imageUrl ;
  String          date ;
  String          open ;
  String          happyHourStart ;
  String          happyHourEnd ;
  bool            isFavorite ;
  List<Product>   products ;
}