
import 'package:flutter/material.dart';
import 'package:projet_b3/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves the user [token] in the SharedPreferences and in a Singleton.
Future<Null>  saveUserToken(String token) async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;
  prefs.setString("AUTHORIZATION", token);

  var singletonInstance = Singleton.instance ;
  singletonInstance.hashKey = token ;
}

Future<String> retrieveAuthorizationToken() async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;

  final   token = prefs.getString("AUTHORIZATION");

  return token ;
}

String        getAuthorizationToken() {
  var singletonInstance = Singleton.instance ;
  print("SINGLETON HASH == ${singletonInstance.hashKey}");
  return singletonInstance.hashKey ;
}

/// Displays a SnackBar on the Scaffold of the [context] to inform the user that
/// the feature is not implemented yet.
void          showFeatureNotReadySnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Désolé, cette fonctionnalité n'est pas encore disponible."),
      duration: Duration(seconds: 2),
    ),
  );
}