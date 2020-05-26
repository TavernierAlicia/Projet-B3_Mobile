import 'dart:convert' as convert ;
import 'dart:io';
//import 'package:http/http.dart';

import 'package:projet_b3/requests/utils.dart';


Future<String>      createUser(String firstName, String name, String mail,
    String password, String confirmPassword, String birthDate,
    String phone) async {
  String              url = BASE_URL + "createUser" ;

  Map<String, dynamic>    formMap = {
    "name": name,
    "surname": firstName,
    "mail": mail,
    "password": password,
    "birth": birthDate,
    "phone": phone,
    "confirmPassword": confirmPassword
  } ;


  final client = HttpClient() ;
  final request = await client.postUrl(Uri.parse(url));
  request.headers.set(HttpHeaders.contentTypeHeader, "application/x-www_form-urlencoded");
  request.followRedirects = true ;
  request.write(formMap);
  final response = await request.close();
  print("STATUS CODE = ${response.statusCode}");
  print("Response location = ${response.headers}");
  print("BODY = ${response.redirects}");

  /*
  http.Response    response = await http.post(
    url,
    body: formMap,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    encoding: convert.Encoding.getByName("utf-8"),
  );
  print("RESPONSE STATUS CODE = ${response.statusCode}");
  print("RESPONSE HEADERS = ${response.headers}");
   */

  return ("TEST") ;

}