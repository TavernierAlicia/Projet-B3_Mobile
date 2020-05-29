import 'dart:convert' as convert ;
import 'dart:io';
//import 'package:http/http.dart';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:projet_b3/requests/utils.dart';

/// Hash the user [password] and [confirmPassword] values, then send a request
/// to the server to create the user account.
Future<int>       createUser(String firstName, String name, String mail,
    String password, String confirmPassword, String birthDate,
    String phone) async {
  String              url = BASE_URL + "createUser/" ;

  Digest    encryptedPassword = sha256.convert(convert.utf8.encode(password));
  Digest    encryptedConfirmPassword = sha256.convert(convert.utf8.encode(confirmPassword));

  String              jsonBody = """
  {
    "name": "$name",
    "surname": "$firstName",
    "mail": "$mail",
    "pass": "$encryptedPassword",
    "birth": "$birthDate",
    "phone": "$phone",
    "confirmPass": "$encryptedConfirmPassword"
  }
  """;

  Response    response = await post(url, body: jsonBody);
  Map<String, dynamic> serverResponse = convert.jsonDecode(response.body);
  return (serverResponse["code"] as int);
}

/// Hash the users [password] value and send a request to the server to get an
/// authorization token.
Future<String>      login(String email, String password) async {
  String    url = BASE_URL + "auth/" ;
  Digest    encryptedPassword = sha256.convert(convert.utf8.encode(password));
  String    jsonBody = """
    {
      "mail":"$email",
      "pass":"$encryptedPassword"
    }
  """ ;

  Response      response = await post(url, body: jsonBody);
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