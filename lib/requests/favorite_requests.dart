import 'dart:convert';

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