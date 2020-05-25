import 'dart:ffi';

class Product {

  Product(int id, String name, String description, double price, int sale,
      double newPrice, String type, {int quantity = 0}) {
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.price = price ;
    this.sale = sale.toDouble() ;
    this.newPrice = newPrice ;
    this.type = type ;
    this.quantity = quantity ;
  }

  factory Product.fromJson(Map<String, dynamic> jsonMap) {
    return Product(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Description"],
      double.tryParse(jsonMap["Price"].toString()),
      jsonMap["Sale"],
      double.tryParse(jsonMap["NewPrice"].toString()),
      jsonMap["Type"],
    );
  }

  int     id ;
  String  name ;
  String  description ;
  double  price ;
  double  sale ;
  double  newPrice ;
  String  type ;
  int     quantity;
}