import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projet_b3/singleton.dart';
import 'package:projet_b3/utils.dart';

class SplashScreen extends StatelessWidget {

  SplashScreen({this.completer, Key key}) : super(key: key);

  final Completer<bool> completer ;

  @override
  Widget build(BuildContext context) {

    Size    _screenSize = window.physicalSize ;

    retrieveAuthorizationToken().then((value) {
      print("VALUE = $value");
      if (value != null) {
        var singletonInstance = Singleton.instance ;
        singletonInstance.hashKey = value ;
      }
      Timer(Duration(seconds: 5), (() {
        print("TIMER FINISHED !");
        completer.complete(value != null) ;
      }));
    });

    return Material(
      child: Container(
        color: Colors.deepOrange,
        width: _screenSize.width,
        height: _screenSize.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        )
      ),
    );
  }
}