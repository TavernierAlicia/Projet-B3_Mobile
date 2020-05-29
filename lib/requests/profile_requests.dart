import 'dart:convert';

import 'package:http/http.dart';
import 'package:projet_b3/model/profile.dart';
import 'package:projet_b3/requests/utils.dart';

import '../utils.dart';

Future<Profile>     getUserProfile() async {
  String    url = BASE_URL + "profile" ;
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response response = await get(url, headers: headers) ;
  var data = jsonDecode(response.body) as List ;
  var profile = data.map<Profile>((json) => Profile.fromJson(json)).toList() ;
  return profile[0] ;
}