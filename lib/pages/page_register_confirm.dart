import 'package:flutter/material.dart';
import 'package:projet_b3/requests/account_requests.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/singleton.dart';

class PageRegisterConfirm extends StatefulWidget {
  PageRegisterConfirm({Key key, this.email, this.password}) : super(key: key);

  final String    email ;
  final String    password ;

  @override
  _PageRegisterConfirmState createState() => _PageRegisterConfirmState();
}

class _PageRegisterConfirmState extends State<PageRegisterConfirm> {

  Size    _screenSize ;

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;

    return Scaffold(
      body: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        color: Colors.deepOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset("assets/circle.png"),
                Image.asset("assets/valid.png"),
              ],
            ),
            Padding(padding: EdgeInsets.all(20),),
            Text(
              "Vous etes inscrit !".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(20),),
            Text(
              "Félicitations et bienvenue sur Order'N drink !",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.all(20),),
            _goToHomeButton(),
            Padding(padding: EdgeInsets.all(20),),
            _goToEditProfile(),
          ],
        ),
      ),
    );
  }

  Widget    _goToHomeButton() {
    return ButtonTheme(
      minWidth: _screenSize.width / 2,
      height: 50,
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("Aller à l'accueil",
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (() {
          _performLoginAndGoTo(
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
          );
        }),
      ),
    );
  }

  Widget    _goToEditProfile() {
    return ButtonTheme(
      minWidth: _screenSize.width / 2,
      height: 50,
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("Modifier le profil",
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (() {
          _performLoginAndGoTo(
            MaterialPageRoute(
              builder: (context) => MainPage(selectedPageDefault: 3,),
            ),
          );
        }),
      ),
    );
  }

  void      _performLoginAndGoTo(MaterialPageRoute pageToGo) {
    login(widget.email, widget.password).then((value) {
      print("In result ; should go to given route");
      if (value != "Login or password wrong") {
        var singletonInstance = Singleton.instance ;
        singletonInstance.hashKey = value ;
        Navigator.of(context).pushReplacement(
          pageToGo,
        );
      }
    });
  }
}