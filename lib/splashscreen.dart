import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_b3/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {

  SplashScreen({this.completer, Key key}) : super(key: key);

  final Completer<bool> completer ;

  @override
  Widget build(BuildContext context) {

    retrieveAuthorizationToken().then((value) {
      print("VALUE = $value");
      if (value != null) {
        var singletonInstance = Singleton.instance ;
        singletonInstance.hashKey = value ;
      }
      completer.complete(value != null) ;
    });

    return Material(
      child: Container(
        color: Colors.deepOrange,
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              scale: 1.5,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> retrieveAuthorizationToken() async {
    SharedPreferences   prefs = await SharedPreferences.getInstance() ;

    final   token = prefs.getString("AUTHORIZATION");

    return token ;
  }

}