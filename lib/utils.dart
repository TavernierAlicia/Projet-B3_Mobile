import 'package:flutter/material.dart';
import 'package:projet_b3/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String AUTHORIZATION_KEY = "AUTHORIZATION" ;

/// ======================================================================== ///
///                            AUTHORIZATION TOKENS                          ///
/// ======================================================================== ///

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

/// ======================================================================== ///
///                                  VALIDATORS                              ///
/// ======================================================================== ///

String          basicValidator(String value) {
  return (value.isEmpty) ? "Ce champ est obligatoire." : null ;
}

String    emailValidator(String value) {
  Pattern   pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$' ;
  RegExp    regex = RegExp(pattern);

  if (value.isEmpty)
    return ("Ce champ est obligatoire") ;
  else if (!regex.hasMatch(value))
    return ("Cet email est invalide.") ;
  else
    return (null) ;
}

String    passwordValidator(String value) {
  if (value.isEmpty)
    return ("Ce champ est obligatoire.");
  else if (value.length < 8)
    return ("Votre mot de passe doit faire au moins 8 caracteres.");
  else
    return (null) ;
}

String    passwordConfirmValidator(String value,
    TextEditingController passwordController) {
  if (value.isEmpty)
    return ("Ce champ est obligatoire.");
  else if (value != passwordController.text)
    return ("Les mots de passe ne correspondent pas.}");
  else
    return (null) ;
}

String    phoneNumberValidator(String value) {
  Pattern   pattern = r'^(?:[+0]9)?[0-9]{10}$' ;
  RegExp    regex = RegExp(pattern);

  if (value.isEmpty)
    return "Ce champ est obligatoire.";
  else if (value.length < 10 || !regex.hasMatch(value))
    return ("Ce numero est invalide.");
  else
    return (null) ;
}

/// ======================================================================== ///
///                                MISCELLANEOUS                             ///
/// ======================================================================== ///

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