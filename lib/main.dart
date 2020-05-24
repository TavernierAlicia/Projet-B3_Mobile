import 'package:flutter/material.dart';
import 'package:projet_b3/pages/page_login.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/user_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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