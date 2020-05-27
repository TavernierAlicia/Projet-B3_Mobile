import 'dart:convert' as convert ;
import 'dart:io';
//import 'package:http/http.dart';

import 'package:http/http.dart';
import 'package:projet_b3/requests/utils.dart';


Future<String>      createUser(String firstName, String name, String mail,
    String password, String confirmPassword, String birthDate,
    String phone) async {
  String              url = BASE_URL + "createUser/" ;
  Map<String, String>   headers = {
    "Accept" : "*/*",
    "Connection" : "keep-alive",
    "Content-Type" : "application/json"
  } ;

  String              jsonBody = """
  {
    "name": "$name",
    "surname": "$firstName",
    "mail": "$mail",
    "pass": "$password",
    "birth": "$birthDate",
    "phone": "$phone",
    "confirmPass": "$confirmPassword"
  }
  """;

  Response    response = await post(url, body: jsonBody);
  print("RESPONSE STATUS CODE = ${response.statusCode}");
  print("RESPONSE HEADERS = ${response.headers}");
  print("RESPONSE BODY = ${response.body}");
  return (convert.jsonDecode(response.body)) ;

}

/*
              An error occured
              Account created
              Mail already exists
*/

/*
Login wrong
Password wrong
 */