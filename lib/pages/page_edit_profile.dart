import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_b3/model/profile.dart';
import 'package:projet_b3/requests/profile_requests.dart';
import 'package:projet_b3/utils.dart';

class PageEditProfile extends StatefulWidget {
  PageEditProfile({Key key, this.profile}) : super(key: key);

  final Profile profile ;

  @override
  _PageEditProfileState createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {

  Size            _screenSize ;
  BuildContext    _scaffoldContext ;
  bool            _isButtonEnabled = true ;
  final           _formKey = GlobalKey<FormState>() ;
  final           _passwordFormKey = GlobalKey<FormState>() ;

  final TextEditingController   _nameEditingController = TextEditingController();
  final TextEditingController   _surnameEditingController = TextEditingController();
  final TextEditingController   _emailEditingController = TextEditingController();
  final TextEditingController   _phoneEditingController = TextEditingController();
  final TextEditingController   _birthDayController = TextEditingController();
  final TextEditingController   _passwordEditingController = TextEditingController();
  final TextEditingController   _newPasswordEditingController = TextEditingController();

  Profile         _profile ;

  @override
  void initState() {
    _profile = widget.profile ;
    _nameEditingController.text = _profile.name ;
    _surnameEditingController.text = _profile.surname ;
    _emailEditingController.text = _profile.mail ;
    _phoneEditingController.text = _profile.phone ;
    _birthDayController.text = _profile.birth ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Modifier mon compte",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: Builder(
        builder: (scaffoldContext) => _editProfileBody(scaffoldContext),
      ),
    );
  }

  Widget    _editProfileBody(BuildContext scaffoldContext) {

    _scaffoldContext = scaffoldContext ;

    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: _screenSize.width / 2,
                  height: _screenSize.width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(_profile.picture).image,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: InkWell(
                    onTap: (() {
                      // TODO
                      print("Should edit profile picture");
                      showFeatureNotReadySnackBar(_scaffoldContext);
                    }),
                    child: Image.asset("assets/edit.png"),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _textFormField(_nameEditingController, basicValidator, false),
                  _textFormField(_surnameEditingController, basicValidator, false),
                  _textFormField(_emailEditingController, emailValidator, false),
                  _textFormField(_phoneEditingController, phoneNumberValidator, true),
                  _birthDatePicker(),
                ],
              ),
            ),
            Form(
              key: _passwordFormKey,
              child: Column(
                children: <Widget>[
                  _passwordTextFormField(_passwordEditingController,
                    passwordValidator, "Mot de passe", false,),
                  _passwordTextFormField(_newPasswordEditingController,
                    passwordValidator, "Nouveau mot de passe", true,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: _editProfileButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget  _textFormField(TextEditingController controller, validator,
      bool isLastField) {
    return TextFormField(
      initialValue: controller.value.text,
      textInputAction: (isLastField)
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepOrange,
            )
        ),
      ),
      validator: ((value) {
        return (validator(value)) ;
      }),
      onFieldSubmitted: ((v) {
        if (!isLastField) FocusScope.of(context).nextFocus();
        else FocusScope.of(context).unfocus();
      }),
      onChanged: ((value) {
        controller.text = value ;
        print("VALUE = $value | CONTROLLER TEXT = ${controller.text}");
      }),
    );
  }

  /// Create the birth date field and the related [DatePicker]. As we need to
  /// change the state of the [TextFormField], we need to create a
  /// [StatefulBuilder].
  Widget    _birthDatePicker() {
    return StatefulBuilder(
        builder: (BuildContext birthDayContext, StateSetter birthDaySetState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20),),
              Text(
                "Date de naissance",
              ),
              Padding(padding: EdgeInsets.all(5),),
              TextFormField(
                controller: _birthDayController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: (() {
                  showDatePicker(
                    context: birthDayContext,
                    initialDate: DateTime(1990),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(DateTime.now().year - 18),
                  ).then((value) {
                    if (value == null) return ;
                    birthDaySetState(() {
                      _birthDayController.text = "${value.year}-${value.month}-${value.day}" ;
                    });
                  });
                }),
              ),
            ],
          );
        }
    );
  }

  Widget  _passwordTextFormField(TextEditingController controller, validator,
      String title, bool isLastField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 10),),
        Text(
          title,
          textAlign: TextAlign.left,
        ),
        TextFormField(
          textInputAction: (isLastField)
              ? TextInputAction.done
              : TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                )
            ),
          ),
          validator: ((value) {
            return (validator(value));
          }),
          onChanged: ((value) {
            controller.text = value ;
          }),
          onFieldSubmitted: ((v) {
            if (!isLastField) FocusScope.of(context).nextFocus();
            else FocusScope.of(context).unfocus();
          }),
        ),
      ],
    );
  }

  Widget  _editProfileButton() {
    return ButtonTheme(
      /// Padding of parent avoid the button to touch screens borders
      minWidth: _screenSize.width,
      height: 50,
      child: FlatButton(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("Valider mon profil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => (_isButtonEnabled) ? _editProfile() : null,
      ),
    );
  }

  /// Check forms, then call [_buildMapProfile] to get a map of the modified
  /// values. If the acquired map is empty, shows an error [SnackBar] ; in the
  /// other case, calls [editUserProfile].
  /// The basic [Form] and the password [Form] are checked separately : The user
  /// can edit his profile without changing his password, but, if he wants to
  /// update it, his current password is required.
  void  _editProfile() {
    if (!_formKey.currentState.validate())
      return ;
    if (_newPasswordEditingController.text.isNotEmpty
        && !_passwordFormKey.currentState.validate())
      return ;

    Map newProfileValues = _buildMapProfile() ;
    newProfileValues.forEach((key, value) {
      print("KEY = $key | VALUE = $value");
    });
    if (newProfileValues.isNotEmpty)
      editUserProfile(newProfileValues).then((value) => handleEditionComplete(value));
    else
      Scaffold.of(_scaffoldContext).showSnackBar(
        SnackBar(
          content: Text("Vous devez modifier au moins un champ !"),
        ),
      );
  }

  /// Generate a [Map] containing all the values of the user's profile.
  /// This [Map] will be converted into json when calling the API.
  Map   _buildMapProfile() {
    Map result = Map() ;

    if (_nameEditingController.text != _profile.name)
      result.putIfAbsent("Name", () => _nameEditingController.text);
    else
      result.putIfAbsent("Name", () => _profile.name);
    if (_surnameEditingController.text != _profile.surname)
      result.putIfAbsent("Surname", () => _surnameEditingController.text);
    else
      result.putIfAbsent("Surname", () => _profile.surname);
    if (_emailEditingController.text != _profile.mail)
      result.putIfAbsent("Mail", () => _emailEditingController.text);
    else
      result.putIfAbsent("Mail", () => _profile.mail);
    if (_phoneEditingController.text != _profile.phone)
      result.putIfAbsent("Phone", () => _phoneEditingController.text);
    else
      result.putIfAbsent("Phone", () => _profile.phone);
    if (_birthDayController.text != _profile.birth)
      result.putIfAbsent("Birth", () => _birthDayController.text);
    else
      result.putIfAbsent("Birth", () => _profile.birth);
    if (_passwordEditingController.text.isNotEmpty
        && _newPasswordEditingController.text.isNotEmpty) {
      result.putIfAbsent("Pass", () => _passwordEditingController.text);
      result.putIfAbsent("NewPass", () => _newPasswordEditingController.text);
    }

    return (result);
  }

  void    handleEditionComplete(int statusCode) {
    setState(() {
      _isButtonEnabled = false ;
    });
    switch (statusCode) {
      case -1 :
        showServerUnavailableSnackBar(_scaffoldContext);
        break ;
      case 0 :
        Navigator.of(context).pop(true);
        break ;
      default:
        showDummyErrorSnackBar(_scaffoldContext);
    }
  }
}