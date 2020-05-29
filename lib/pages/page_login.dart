import 'package:flutter/material.dart';
import 'package:projet_b3/colors.dart';
import 'package:projet_b3/pages/page_main.dart';
import 'package:projet_b3/pages/page_register.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:projet_b3/singleton.dart';
import 'package:projet_b3/user_data.dart';
import 'package:projet_b3/requests/account_requests.dart';
import 'package:projet_b3/views/form_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class PageLogin extends StatefulWidget {
  PageLogin({Key key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  double                        _screenWidth ;
  final                         _formKey = GlobalKey<FormState>() ;
  BuildContext                  _scaffoldContext ;

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
      body: Builder(
        builder: (scaffoldContext) => _loginBody(scaffoldContext),
      ),
    );
  }

  Widget    _loginBody(BuildContext scaffoldContext) {

    _scaffoldContext = scaffoldContext ;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                formItem(
                  context,
                  "Identifiant",
                  "Entrez l'identifiant",
                  _basicValidator,
                  _loginController,
                  textInputType: TextInputType.emailAddress,
                ),
                formItem(
                  context,
                  "Mot de passe",
                  "Entrez le mot de passe",
                  _basicValidator,
                  _passwordController,
                  obscureText: true,
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10),),
          _forgotPassword(),
          Padding(padding: EdgeInsets.only(top: 40),),
          _loginButton(),
          Padding(padding: EdgeInsets.only(top: 20),),
          Text("ou"),
          Padding(padding: EdgeInsets.only(top: 20),),
          _registerButton(),
          //Padding(padding: EdgeInsets.only(top: 20),),
          //_connectionAlternatives(),
        ],
      ),
    );
  }

  /// Returns an error message if [value] is empty.
  String    _basicValidator(String value) {
    return (value.isEmpty) ? "Ce champ est obligatoire." : null ;
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
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("Se connecter",
          style: TextStyle(
            color: ClickNDrinkColors.WHITE,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (() {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _performLogin();
          }
        }),
      ),
    );
  }

  Widget    _registerButton() {
    return ButtonTheme(
      /// Padding of parent avoid the button to touch screens borders
      minWidth: _screenWidth,
      height: 50,
      child: FlatButton(
        color: ClickNDrinkColors.PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("S'inscrire",
          style: TextStyle(
            color: ClickNDrinkColors.WHITE,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PageRegister() ;
              }
            )
          );
        }),
      ),
    );
  }

  /// Tries to perform login with the current credentials in the text fields.
  /// If the login fails, display a SnackBar.
  /// If the login succeeds, calls [saveUserToken], then go to MainPage.
  void _performLogin() {
    if (_loginController.text.isEmpty || _passwordController.text.isEmpty)
      return ;
    login(_loginController.text, _passwordController.text).then((value) {
      if (value[0] as int != SERVER_RESPONSE_NO_ERROR) {
        saveUserToken(value[1] as String).then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
          );
        });
      } else {
        Scaffold.of(_scaffoldContext).showSnackBar(
          SnackBar(
            content: Text(getServerErrorMessage(value[0] as int)),
          ),
        );
      }
    });
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

}