import 'dart:convert';

import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

Future<List<Bar>>    getBarsList() async {
  String    url = BASE_URL + "app/show" ;
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response  response = await get(url, headers: headers) ;
  int       statusCode = response.statusCode ;
  var       data = jsonDecode(response.body) as List ;
  var       barsList = data.map<Bar>((json) => Bar.fromJson(json)).toList();
  barsList.forEach((element) {
    print("ELEMENT ${element.name}");
  });
  return barsList ;
}