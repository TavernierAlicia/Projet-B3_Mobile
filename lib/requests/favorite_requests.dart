import 'dart:convert';

import 'package:projet_b3/model/bar_info.dart';
import 'package:projet_b3/model/favorite.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

import '../utils.dart';

Future<List<Favorite>>    getFavorites() async {
  String    url = BASE_URL + "favs" ;
  Map<String, String> headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response    response = await get(url, headers: headers) ;
  var data = jsonDecode(response.body) as List ;
  var favorites = data.map<Favorite>((json) => Favorite.fromJson(json)).toList();
  return favorites ;
}

Future<String>        addToFavorites(int toAddId) async {
  String    url = BASE_URL + "favs/add/" + toAddId.toString() ;
  Map<String, String> headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response    response = await post(url, headers: headers);

  return jsonDecode(response.body) ;
}

Future<String>        removeFromFavorites(int toRemoveId) async {
  String url = BASE_URL + "favs/delete/" + toRemoveId.toString() ;
  print("URL = $url");
  Map<String, String> headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response    response = await delete(url, headers: headers);

  print("STATUS CODE = ${response.statusCode}");
  print("DELETE FAV RESPONSE = ${response.body}");
  print("decoded = ${jsonDecode(response.body)}");
  return jsonDecode(response.body) ;
}