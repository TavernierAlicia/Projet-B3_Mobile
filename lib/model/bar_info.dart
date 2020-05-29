import 'package:projet_b3/model/bar_details.dart';
import 'package:projet_b3/model/product.dart';

class BarInfo {

  BarInfo(BarDetails barDetails, List<Product> products) {
    this.barDetails = barDetails ;
    this.products = products ;
  }

  factory BarInfo.fromJson(Map<String, dynamic> json) {

    print("In BarInfo factory ; json = $json");
    List<BarDetails>    _barDetails = [];
    List<Product>       _products = [] ;

    if (json != null && json["BarDetails"] != null) {
      var jsonBarDetails = json["BarDetails"] as List ;
      if (jsonBarDetails.length > 0) {
        _barDetails =
            jsonBarDetails.map<BarDetails>((json) => BarDetails.fromJson(json))
                .toList();
      }
    }
    if (json != null && json["Items"] != null) {
      var jsonProducts = json["Items"] as List ;
      if (jsonProducts.length > 0) {
        _products =
            jsonProducts.map<Product>((json) => Product.fromJson(json))
                .toList() ;
      }
    }

    return BarInfo(
      _barDetails[0],
      _products,
    );
  }

  BarDetails      barDetails ;
  List<Product>   products ;
}