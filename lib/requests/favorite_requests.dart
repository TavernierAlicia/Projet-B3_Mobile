import 'dart:convert';

import 'package:projet_b3/model/bar_info.dart';
import 'package:projet_b3/model/favorite.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

Future<List<Favorite>>    getFavorites() async {
  String    url = BASE_URL + "favs" ;
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response    response = await get(url, headers: headers) ;
  var data = jsonDecode(response.body) as List ;
  var favorites = data.map<Favorite>((json) => Favorite.fromJson(json)).toList();
  return favorites ;
}

Future<String>        addToFavorites(BarInfo barInfo) async {
  String    url = BASE_URL + "favs/add/" + barInfo.barDetails.id.toString() ;
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response    response = await post(url, headers: headers);

  return jsonDecode(response.body) ;
}

Future<String>        removeFromFavorites(BarInfo barInfo) async {
  String url = BASE_URL + "favs/delete/" + barInfo.barDetails.id.toString() ;
  print("URL = $url");
  Map<String, String> headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  Response    response = await delete(url, headers: headers);

  print("STATUS CODE = ${response.statusCode}");
  print("DELETE FAV RESPONSE = ${response.body}");
  print("decoded = ${jsonDecode(response.body)}");
  return jsonDecode(response.body) ;
}