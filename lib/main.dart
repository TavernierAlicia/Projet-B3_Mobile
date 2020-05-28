import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_b3/pages/page_login.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/splashscreen.dart';
import 'package:projet_b3/user_data.dart';

void main() async {

  final   completer = Completer<bool>() ;

  runApp(SplashScreen(completer: completer,));

  bool    isLoggedIn = await completer.future ;

  runApp(MaterialApp(
    home: (isLoggedIn) ? MainPage() : PageLogin(),
    title: "Order'N Drink",
    theme: ThemeData(
        primarySwatch: Colors.deepOrange
    ),
  ));
}



class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );

    return MaterialApp(
      title: 'Projet B3',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: (isUserLoggedIn) ? MainPage() : PageLogin(),
      routes: {
        "page_login" : (context) => PageLogin(),
        "page_main" : (context) => MainPage(),
      },
    );
  }
}