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

Future<List<dynamic>>        addToFavorites(int toAddId) async {
  String    url = BASE_URL + "favs/add/" + toAddId.toString() ;
  Map<String, String> headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response              response = await post(url, headers: headers);
  Map<String, dynamic>  serverResponse = jsonDecode(response.body);

  return ([serverResponse["code"], serverResponse["message"]]);
}

Future<List<dynamic>>        removeFromFavorites(int toRemoveId) async {
  String url = BASE_URL + "favs/delete/" + toRemoveId.toString() ;
  print("URL = $url");
  Map<String, String> headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response              response = await delete(url, headers: headers);
  Map<String, dynamic>  serverResponse = jsonDecode(response.body);

  return ([serverResponse["code"], serverResponse["message"]]) ;
}