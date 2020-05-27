import 'package:flutter/material.dart';
import 'package:projet_b3/pages/page_register_confirm.dart';
import 'package:projet_b3/requests/account_requests.dart';

class PageRegister extends StatefulWidget {
  PageRegister({Key key}) : super(key: key);

  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {

  final           _formKey = GlobalKey<FormState>() ;
  double          _screenWidth = 0 ;

  final   TextEditingController   _firstNameController = TextEditingController();
  final   TextEditingController   _nameController = TextEditingController();
  final   TextEditingController   _emailController = TextEditingController();
  final   TextEditingController   _birthDayController = TextEditingController();
  final   TextEditingController   _passwordController = TextEditingController();
  final   TextEditingController   _confPassController = TextEditingController();
  final   TextEditingController   _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "S'enregistrer".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (scaffoldContext) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _formItem(
                          "Prenom",
                          "Entrez votre prenom",
                          _basicValidator,
                          _firstNameController,
                        ),
                        _formItem(
                          "Nom",
                          "Entrez votre nom",
                          _basicValidator,
                          _nameController,
                        ),
                        _formItem(
                          "Email",
                          "Entrez votre email",
                          _emailValidator,
                          _emailController,
                        ),
                        _birthDatePicker(),
                        _formItem(
                          "Mot de passe",
                          "Entrez votre mot de passe",
                          _passwordValidator,
                          _passwordController,
                          obscureText: true,
                        ),
                        _formItem(
                          "Confirmez mot de passe",
                          "Confirmez votre mot de passe",
                          _passwordConfirmValidator,
                          _confPassController,
                          obscureText: true,
                        ),
                        _formItem(
                          "Numero de telephone",
                          "Numero de telephone",
                          _phoneNumberValidator,
                          _phoneController,
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20),),
                  _registerButton(scaffoldContext),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String    _basicValidator(String value) {
    return (value.isEmpty) ? "Ce champ est obligatoire." : null ;
  }

  String    _emailValidator(String value) {
    Pattern   pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$' ;
    RegExp    regex = RegExp(pattern);

    if (value.isEmpty)
      return ("Ce champ est obligatoire") ;
    else if (!regex.hasMatch(value))
      return ("Cet email est invalide.") ;
    else
      return (null) ;
  }

  String    _passwordValidator(String value) {
    if (value.isEmpty)
      return ("Ce champ est obligatoire.");
    else if (value.length < 8)
      return ("Votre mot de passe doit faire au moins 8 caracteres.");
    else
      return (null) ;
  }

  String    _passwordConfirmValidator(String value) {
    if (value.isEmpty)
      return ("Ce champ est obligatoire.");
    else if (value != _passwordController.text)
      return ("Les mots de passe ne correspondent pas.}");
    else
      return (null) ;
  }

  String    _phoneNumberValidator(String value) {
    Pattern   pattern = r'^(?:[+0]9)?[0-9]{10}$' ;
    RegExp    regex = RegExp(pattern);

    if (value.isEmpty)
      return "Ce champ est obligatoire.";
    else if (value.length < 10 || !regex.hasMatch(value))
      return ("Ce numero est invalide.");
    else
      return (null) ;
  }

  Widget    _formItem(String title, String hint, validator,
      TextEditingController controller,
      { obscureText = false }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20),),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.all(5),),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: ((value) {
            return (validator(value));
          }),
        ),
      ],
    );
  }

  Widget    _birthDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20),),
        Text(
          "Date de naissance".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.all(5),),
        TextFormField(
          controller: _birthDayController,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: "Selectionnez votre date de naissance",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          validator: ((value) {
            return _basicValidator(value) ;
          }),
          onTap: (() {
            print("Should open datePicker");
            showDatePicker(
              context: context,
              initialDate: DateTime(1990),
              firstDate: DateTime(1970),
              lastDate: DateTime(DateTime.now().year - 18),
            ).then((value) {
              setState(() {
                _birthDayController.text = "${value.year}-${value.month}-${value.day}" ;
              });
            });
          }),
          onSaved: ((value) {
            print("onSaved, newValue = $value");
          }),
        ),
      ],
    );
  }

  Widget    _registerButton(BuildContext scaffoldContext) {
    return ButtonTheme(
      /// Padding of parent avoid the button to touch screens borders
      minWidth: _screenWidth,
      height: 50,
      child: FlatButton(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("S'inscrire",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (() {
          print("In onPressed ; validate = ${_formKey.currentState.validate()}");
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            createUser(
              _firstNameController.text,
              _nameController.text,
              _emailController.text,
              _passwordController.text,
              _confPassController.text,
              _birthDayController.text,
              _phoneController.text,
            ).then((value) {
              print("VALUE = |$value|");
              if (value != "Account created") {
                Scaffold.of(scaffoldContext).showSnackBar(
                  SnackBar(
                    content: Text(value),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageRegisterConfirm(),
                  ),
                );
              }
            });
          }
        }),
      ),
    );
  }
}