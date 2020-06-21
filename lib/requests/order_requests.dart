
import 'dart:convert';

import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/model/order.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

import '../utils.dart';

Future<int>  takeOrder(int barId, List<Product> cartContent, int arrivingIn,
    int tip, PaymentMethod paymentMethod) async {
  String                url = BASE_URL + "takeOrder" ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  List<int> products = [] ;
  print("In takeOrder request ; cartContent has ${cartContent.length} elements");
  cartContent.forEach((element) {
    print("In takeOrder cartContent for loop, element ${element.name} has quantity ${element.quantity}");
    for (var i = 0 ; i < element.quantity ; i++) {
      products.add(element.id);
    }
  });

  String    arrivingInString = "00:";
  if (arrivingIn == 0) arrivingInString += "00";
  else arrivingInString += arrivingIn.toString() ;

  String                jsonBody = """
    {
      "etab_id":$barId,
      "instructions":"",
      "waiting_time":"00:$arrivingInString",
      "payment":"${paymentMethod.toString().replaceAll("PaymentMethod.", "")}",
      "tip":$tip,
      "items_id":$products
    }
  """ ;

  print("JSON BODY == $jsonBody");

  Response    response = await post(url, headers: headers, body: jsonBody);
  print("RESPONSE BODY = ${response.body}");
  try {
    print("In try");
    var data = jsonDecode(response.body);
    print("Got data : $data ; code = ${data["code"]} | message = ${data["message"]}");
    int code = data["code"] ;
    print("CODE = $code");
    if (data["code"] != null && data["code"] == 0 && data["message"] != null) {
      return (data["message"]);
    }
  } catch (exception) {
    print("EXCEPTION : $exception");
  }
  return -1 ;
}

Future<List<Order>>     getOrdersHistory() async {
  String        url = BASE_URL + "showOrders" ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response    response = await get(url, headers: headers) ;
  print("Response status code = ${response.statusCode}");
  print("Response body = ${response.body}");
  var data = jsonDecode(response.body) as List;
  var ordersList = data.map<Order>((json) => Order.fromJson(json)).toList();

  return ordersList ;
}

Future<Order>           getOrderDetails(int orderId) async {
  String        url = BASE_URL + "getOrder/" + orderId.toString() ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  };

  Response      response = await get(url, headers: headers) ;
  var           data = jsonDecode(response.body) as List; // TODO : Unset list in server
  print("Response status code = ${response.statusCode}");
  print("Response body = ${response.body}");
  var order = data.map<Order>((json) => Order.detailsFromJson(json)).toList();

  return order[0] ;
}