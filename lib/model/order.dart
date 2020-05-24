import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';

class Order {

  Order(Bar bar, DateTime dateTime, List<Product> products, double totalPrice) {
    this.bar = bar ;
    this.dateTime = dateTime ;
    this.products = products ;
    this.totalPrice = totalPrice ;
  }

  Bar           bar ;
  DateTime      dateTime ;
  List<Product> products ;
  double        totalPrice ;

}