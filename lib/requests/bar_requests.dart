import 'dart:convert';

import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

Future<List<Bar>>    getBarsList() async {
  String    url = BASE_URL + "show" ;
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response  response = await get(url, headers: headers) ;
  int       statusCode = response.statusCode ;
  var       data = jsonDecode(response.body) as List ;
  var       barsList = data.map<Bar>((json) => Bar.fromJson(json)).toList();
  return barsList ;
}

Future<List<Product>>   getBarCart(Bar bar) async {
  String    url = BASE_URL + "show/${bar.id}" ;
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       data = jsonDecode(response.body)["Items"] as List ;
  var       productsList = data.map<Product>((json) => Product.fromJson(json)).toList();

  productsList.forEach((element) {
    print("New element ; ${element.name}");
  });
  return productsList ;
}