import 'package:flutter/material.dart';
import 'package:projet_b3/colors.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/user_data.dart';

class PageLogin extends StatefulWidget {
  PageLogin({Key key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  double                        _screenWidth ;

  final TextEditingController   _loginController = TextEditingController() ;
  final TextEditingController   _passwordController = TextEditingController() ;

  @override
  void initState() {
    /// Init text editing controllers.
    _loginController.addListener(() {});
    _passwordController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    /// Remove text editing controllers.
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// Setup basic variables
    _screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: (!isUserLoggedIn)
          ? AppBar(
        backgroundColor: Colors.white,
        title: Text("Connexion".toUpperCase(),
          style: TextStyle(
            color: ClickNDrinkColors.BLACK,
          ),
        ),
        centerTitle: true,
      )
          : null,
      backgroundColor: ClickNDrinkColors.WHITE,
      body: _loginBody(),
    );
  }

  Widget    _loginBody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          _loginRequest(),
          Padding(padding: EdgeInsets.only(top: 20),),
          _passwordRequest(),
          Padding(padding: EdgeInsets.only(top: 10),),
          _forgotPassword(),
          Padding(padding: EdgeInsets.only(top: 40),),
          _loginButton(),
          Padding(padding: EdgeInsets.only(top: 20),),
          _connectionAlternatives(),
          Padding(padding: EdgeInsets.only(top: 40),),
          _newUser(),
        ],
      ),
    );
  }

  Widget    _loginRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Identifiant".toUpperCase(),
          style: TextStyle(
              color: ClickNDrinkColors.BLACK,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Entrer l'identifiant",
          ),
        ),
      ],
    );
  }

  Widget    _passwordRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Mot de passe".toUpperCase(),
          style: TextStyle(
              color: ClickNDrinkColors.BLACK,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Entrer le mot de passe",
          ),
        ),
      ],
    );
  }

  /// TODO : Set an action to perform in case of click.
  Widget    _forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("Mot de passe oublié ?",
          style: TextStyle(
              color: ClickNDrinkColors.FIELDS_BACKGROUND_ACCENT,
              decoration: TextDecoration.underline,
              fontSize: 15
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 10),),
        Icon(
          Icons.arrow_forward,
          color: ClickNDrinkColors.FIELDS_BACKGROUND_ACCENT,
        ),
      ],
    );
  }

  Widget    _loginButton() {
    return ButtonTheme(
      /// Padding of parent avoid the button to touch screens borders
      minWidth: _screenWidth,
      height: 50,
      child: FlatButton(
        color: ClickNDrinkColors.PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Se connecter",
          style: TextStyle(
              color: ClickNDrinkColors.WHITE,
              fontSize: 15
          ),
        ),
        onPressed: (() {
          _performLogin() ; // TODO
        }),
      ),
    );
  }

  Widget    _connectionAlternatives() {
    return Column(
      children: <Widget>[
        Text("ou"),
        Padding(padding: EdgeInsets.all(15),),
        Text("Se connecter avec :".toUpperCase(),
          style: TextStyle(
              color: ClickNDrinkColors.BLACK,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
        ),
        Padding(padding: EdgeInsets.all(10),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (() {
                print("Clicked on Facebook !");
                // TODO
              }),
              child: Image.asset(
                'assets/facebook.png',
                scale: 1.5,
              ),
            ),
            GestureDetector(
              onTap: (() {
                print("Clicked on Google + !");
                // TODO
              }),
              child: Image.asset(
                'assets/google.png',
                scale: 1.5,
              ),
            ),
            GestureDetector(
              onTap: (() {
                print("Clicked on Instagram !");
                // TODO
              }),
              child: Image.asset(
                'assets/instagram.png',
                scale: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget    _newUser() {
    return Container(
      child: Text("Nouveau membre ?",
        style: TextStyle(
          color: ClickNDrinkColors.FIELDS_BACKGROUND_ACCENT,
          fontSize: 15,
        ),
      ),
    );
  }

  /// Tries to perform login with the current credentials in the text fields.
  /// TODO : Set a real login
  void _performLogin() {
    setState(() {
      isUserLoggedIn = true;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }
}