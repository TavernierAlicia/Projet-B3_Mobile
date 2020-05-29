import 'dart:convert';

import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/bar_info.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';
import 'package:projet_b3/utils.dart';
import 'package:query_params/query_params.dart';


Future<List<Bar>>    getBarsList() async {
  String                url = BASE_URL + "show" ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       data = jsonDecode(response.body) as List ;
  var       barsList = data.map<Bar>((json) => Bar.fromJson(json)).toList();
  return barsList ;
}

Future<List<Bar>>   searchBars(String search) async {
  String                url = BASE_URL + "search/?search=" + search ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       barList = (jsonDecode(response.body) as List)
      .map<Bar>((json) => Bar.fromJson(json)).toList();
  print("In searchBars request ; returning a list of ${barList.length} bars.");
  return barList ;
}

Future<List<Bar>>   searchBarsByFilters({
  String type = "", String distance = "", String popularity = "",
  String lat = "", String long = ""
}) async {
  String                url = BASE_URL + "show" ;
  URLQueryParams        queryParams = URLQueryParams();
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  if (type.isNotEmpty)
    queryParams.append("type", type);
  if (distance.isNotEmpty)
    queryParams.append("distance", distance);
  if (popularity.isNotEmpty) {
    queryParams.append("popularity", popularity);
    queryParams.append("lat", lat);
    queryParams.append("long", long);
  }
  print("query = ${queryParams.toString()}");
  url += "?" + queryParams.toString();

  Response    response = await get(url, headers: headers) ;
  var         barList = (jsonDecode(response.body) as List)
      .map<Bar>((json) => Bar.fromJson(json)).toList();
  return barList ;
}

Future<BarInfo>     getBarInfo(Bar bar) async {
  String                url = BASE_URL + "show/${bar.id}" ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response  response = await get(url, headers: headers) ;
  var       data = (json.decode(response.body)) ;
  var       barInfo = BarInfo.fromJson(data) ;

  print("End of getBarInfo request : ${barInfo.barDetails.name} || ${response.body}");
  return barInfo ;
}