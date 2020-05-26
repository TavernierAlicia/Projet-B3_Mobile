import 'package:projet_b3/model/bar_details.dart';
import 'package:projet_b3/model/product.dart';

class BarInfo {

  BarInfo(BarDetails barDetails, List<Product> products) {
    this.barDetails = barDetails ;
    this.products = products ;
  }

  factory BarInfo.fromJson(Map<String, dynamic> json) {

    List<BarDetails>    _barDetails = [];
    List<Product>       _products = [] ;

    var jsonBarDetails = json["BarDetails"] as List ;
    var jsonProducts = json["Items"] as List ;

    _barDetails = jsonBarDetails.map<BarDetails>((json) => BarDetails.fromJson(json)).toList();
    _products = jsonProducts.map<Product>((json) => Product.fromJson(json)).toList() ;

    return BarInfo(
      _barDetails[0],
      _products,
    );
  }

  BarDetails      barDetails ;
  List<Product>   products ;
}