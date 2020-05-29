
import 'package:flutter/material.dart';
import 'package:projet_b3/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String AUTHORIZATION_KEY = "AUTHORIZATION" ;

/// Saves the user [token] in the SharedPreferences and in a Singleton.
Future<Null>    saveUserToken(String token) async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;
  prefs.setString(AUTHORIZATION_KEY, token);

  var singletonInstance = Singleton.instance ;
  singletonInstance.hashKey = token ;
}

Future<Null>    forgetUserToken() async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;
  prefs.remove(AUTHORIZATION_KEY);
}

Future<String>  retrieveAuthorizationToken() async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;

  final   token = prefs.getString(AUTHORIZATION_KEY);

  return token ;
}

String          getAuthorizationToken() {
  var singletonInstance = Singleton.instance ;
  print("SINGLETON HASH == ${singletonInstance.hashKey}");
  return singletonInstance.hashKey ;
}

/// Displays a SnackBar on the Scaffold of the [context] to inform the user that
/// the feature is not implemented yet.
void            showFeatureNotReadySnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Désolé, cette fonctionnalité n'est pas encore disponible."),
      duration: Duration(seconds: 2),
    ),
  );
}