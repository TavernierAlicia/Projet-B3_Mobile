import 'dart:convert';

import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/bar_info.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

Future<List<Bar>>    getBarsList() async {
  String                url = BASE_URL + "show" ;
  Map<String, String>   headers = {
    "Authorization" : "6d60e931-856c-4927-bca2-344be1cfe135"
  } ;

  Response  response = await get(url, headers: headers) ;
  int       statusCode = response.statusCode ;
  var       data = jsonDecode(response.body) as List ;
  var       barsList = data.map<Bar>((json) => Bar.fromJson(json)).toList();
  return barsList ;
}

Future<List<Bar>>   searchBars(String search) async {
  String                url = BASE_URL + "search/?search=" + search ;
  Map<String, String>   headers = {
    "Authorization" : "6d60e931-856c-4927-bca2-344be1cfe135"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       barList = (jsonDecode(response.body) as List)
      .map<Bar>((json) => Bar.fromJson(json)).toList();
  print("In searchBars request ; returning a list of ${barList.length} bars.");
  return barList ;
}

Future<List<Bar>>   getBarsListFilters({
  String type = "", String distance = "", String popularity = "",
  String lat = "", String long = ""
}) async {
  String                url = BASE_URL + "show" ;
  String                query = "?" ;

  requestBuilder(query, "type", type) ;
  requestBuilder(query, "distance", distance) ;
  requestBuilder(query, "popularity", popularity) ;
  requestBuilder(query, "lat", lat) ;
  requestBuilder(query, "long", long) ;

  print("query = $query");
}

String              requestBuilder(String original, String key, dynamic value) {
  String result = original ;

  if (result != "?")
    result += "&";
  if (value.toString().isNotEmpty) {
    result += "$key=$value" ;
  }
  return result ;
}

Future<BarInfo>     getBarInfo(Bar bar) async {
  String                url = BASE_URL + "show/${bar.id}" ;
  Map<String, String>   headers = {
    "Authorization" : "6d60e931-856c-4927-bca2-344be1cfe135"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       data = (json.decode(response.body)) ;
  var       barInfo = BarInfo.fromJson(data) ;

  return barInfo ;
}