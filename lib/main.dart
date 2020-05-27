import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_b3/pages/page_login.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/user_data.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
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

    return new SplashScreen(
      seconds: 5,  // TODO
      navigateAfterSeconds: (isUserLoggedIn) ? MainPage() : PageLogin(),
      backgroundColor: Colors.deepOrange,
      styleTextUnderTheLoader: new TextStyle(),
      imageBackground: Image.asset("assets/logo.png").image,
      loaderColor: Colors.white,
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

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Succeeded!",
          style: new TextStyle(fontWeight: FontWeight.bold,
              fontSize: 30.0),
        ),
      ),
    );
  }
}