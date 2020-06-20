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
  print("IN GET USER PROFILE ; BODY = ${response.body}");
  var data = jsonDecode(response.body) as List ;
  var profile = data.map<Profile>((json) => Profile.fromJson(json)).toList() ;
  return profile[0] ;
}

Future<int>         editUserProfile(Map newProfileValues) async {
  String                url = BASE_URL + "profile/edit/" ;
  JsonEncoder           jsonEncoder = JsonEncoder() ;
  String                jsonBody = jsonEncoder.convert(newProfileValues);
  Map<String, String>   headers = {
    "Authorization" : "${getAuthorizationToken()}"
  } ;

  Response response = await put(url, headers: headers, body: jsonBody) ;
  try {
    var data = jsonDecode(response.body);
    if (data["code"] == 0) saveUserToken(data["message"]);
    return (data["code"]) ;
  } catch (exception) {}
  return (-1);
}