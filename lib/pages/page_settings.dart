import 'dart:async';

import 'package:flutter/material.dart';

import '../utils.dart';

class PageSettings extends StatefulWidget {
  PageSettings({Key key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {

  bool    _usesDarkMode = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Paramètres".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _profileButton(),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10),),
            _appTheme(),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10),),
            _helpSection(),
            Padding(padding: EdgeInsets.only(top: 15, bottom: 15),),
            _generalSection(),
            Padding(padding: EdgeInsets.only(top: 15, bottom: 15),),
            _logoutButton(),
          ],
        ),
      ),
    );
  }
  
  Widget    _profileButton() {
    return InkWell(
        onTap: (() {
          // TODO : Go to profile
          print("Should go to profile");
        }),
        child: Wrap(
          children: <Widget>[
            Text(
              "Mon profil".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 20),),
            Image.asset(
              "assets/edit.png",
              scale: 2,
            ),
          ],
        )
    );
  }

  Widget    _appTheme() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          "Mode jour",
          style: TextStyle(
            color: (_usesDarkMode) ? Colors.grey : Colors.black,
          ),
        ),
        Switch(
          value: _usesDarkMode,
          onChanged: ((newValue) {
            setState(() {
              _usesDarkMode = true ;
              _changeAppTheme();
            });
          }),
        ),
        Text(
          "Mode nuit",
          style: TextStyle(
            color: (_usesDarkMode) ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget    _helpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Aide".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5, bottom: 5),),
        InkWell(
          onTap: (() {
            // TODO
            showFeatureNotReadySnackBar(context);
          }),
          child: Text(
            "FAQ",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5, bottom: 5),),
        InkWell(
          onTap: (() {
            // TODO
            showFeatureNotReadySnackBar(context);
          }),
          child: Text(
            "Service Client",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget    _generalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Général".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5, bottom: 5),),
        InkWell(
          onTap: (() {
            // TODO
            showFeatureNotReadySnackBar(context);
          }),
          child: Text(
            "Mentions légales",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget    _logoutButton() {
    return InkWell(
        onTap: (() {
          // TODO : Logout
          showFeatureNotReadySnackBar(context);
          print("Should logout");
        }),
        child: Text(
          "Déconnexion".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
    );
  }

  void      _changeAppTheme() {
    showFeatureNotReadySnackBar(context);
    Timer(Duration(seconds: 2), (() {
      setState(() {
        _usesDarkMode = false ;
      });
    }));
  }
}