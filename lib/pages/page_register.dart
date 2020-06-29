import 'package:flutter/material.dart';
import 'package:projet_b3/pages/page_register_confirm.dart';
import 'package:projet_b3/requests/account_requests.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:projet_b3/utils.dart';
import 'package:projet_b3/views/form_item.dart';

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
                        formItem(
                          context,
                          "Prenom",
                          "Entrez votre prenom",
                          basicValidator,
                          _firstNameController,
                        ),
                        formItem(
                          context,
                          "Nom",
                          "Entrez votre nom",
                          basicValidator,
                          _nameController,
                        ),
                        formItem(
                          context,
                          "Email",
                          "Entrez votre email",
                          emailValidator,
                          _emailController,
                          textInputType: TextInputType.emailAddress,
                        ),
                        _birthDatePicker(),
                        formItem(
                          context,
                          "Mot de passe",
                          "Entrez votre mot de passe",
                          passwordValidator,
                          _passwordController,
                          obscureText: true,
                        ),
                        formItem(
                          context,
                          "Confirmez mot de passe",
                          "Confirmez votre mot de passe",
                          _passwordConfirmValidator,
                          _confPassController,
                          obscureText: true,
                        ),
                        formItem(
                          context,
                          "Numero de telephone",
                          "Numero de telephone",
                          phoneNumberValidator,
                          _phoneController,
                          textInputType: TextInputType.number,
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
            return basicValidator(value) ;
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
              if (value != SERVER_RESPONSE_NO_ERROR) {
                Scaffold.of(scaffoldContext).showSnackBar(
                  SnackBar(
                    content: Text(getServerErrorMessage(value)),
                  ),
                );
              } else {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageRegisterConfirm(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  ),
                );
              }
            });
          }
        }),
      ),
    );
  }

  String    _passwordConfirmValidator(String value) {
    if (value.isEmpty)
      return ("Ce champ est obligatoire.");
    else if (value != _passwordController.text)
      return ("Les mots de passe ne correspondent pas.}");
    else
      return (null) ;
  }
}