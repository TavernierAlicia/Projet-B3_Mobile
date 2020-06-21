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
  final           _formKey = GlobalKey<FormState>() ;
  final           _passwordFormKey = GlobalKey<FormState>() ;
  final           _newPasswordFormKey = GlobalKey<FormState>() ;

  final TextEditingController   _nameEditingController = TextEditingController();
  final TextEditingController   _surnameEditingController = TextEditingController();
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
                      image: Image.network(
                          (_profile.picture.isNotEmpty)
                              ? _profile.picture
                              : "http://cdn.orderndrink.com/img/profile.png"
                      ).image,
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
                  _textFormField(_surnameEditingController, basicValidator, true),
                  _emailField(),
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
                    basicValidator, "Mot de passe", false,),
                ],
              ),
            ),
            Form(
              key: _newPasswordFormKey,
              child: Column(
                children: <Widget>[
                  _passwordTextFormField(_newPasswordEditingController,
                    _newPasswordValidator, "Nouveau mot de passe", true,),
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

  /// The email is not editable.
  Widget  _emailField() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: TextFormField(
        initialValue: _profile.mail,
        keyboardType: TextInputType.text,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
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
        onPressed: () => _editProfile(),
      ),
    );
  }

  /// Checks if the new password the user choose is correct. We also check if
  /// the current password field is filled, as it it needed for password change.
  String    _newPasswordValidator(String value) {
    if (_passwordFormKey.currentState.validate())
      return (null);
    if (value.isEmpty)
      return ("Ce champ est obligatoire.");
    else if (value.length < 8)
      return ("Votre mot de passe doit faire au moins 8 caracteres.");
    else
      return (null);
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
        && !_newPasswordFormKey.currentState.validate())
      return ;

    if (areFieldsDifferent()) {
      Map newProfileValues = _buildMapProfile();
      editUserProfile(newProfileValues).then((value) =>
          handleEditionComplete(value));
    } else
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

    result.putIfAbsent("Mail", () => _profile.mail);
    result.putIfAbsent("Name", () => _nameEditingController.text);
    result.putIfAbsent("Surname", () => _surnameEditingController.text);
    result.putIfAbsent("Phone", () => _phoneEditingController.text);
    result.putIfAbsent("Birth", () => _birthDayController.text);
    if (_passwordEditingController.text.isNotEmpty
        && _newPasswordEditingController.text.isNotEmpty) {
      result.putIfAbsent("Pass", () => _passwordEditingController.text);
      result.putIfAbsent("NewPass", () => _newPasswordEditingController.text);
    }

    return (result);
  }

  /// Return true if the user modified something in his profile. If nothing has
  /// been modified, no need to call the API.
  bool    areFieldsDifferent() {
    return (_nameEditingController.text != _profile.name
        || _surnameEditingController.text != _profile.surname
        || _phoneEditingController.text != _profile.phone
        || _birthDayController.text != _profile.birth
        || (_passwordEditingController.text.isNotEmpty
            && _newPasswordEditingController.text.isNotEmpty));
  }

  /// Wait for the result of [editUserProfile]. If the call fails, display an
  /// error [SnackBar]. If the [statusCode] is equal to 0, close this page with
  /// a true value.
  void    handleEditionComplete(int statusCode) {
    print("STATUS CODE = $statusCode");
    switch (statusCode) {
      case -1 :
        showServerUnavailableSnackBar(_scaffoldContext);
        break ;
      case 0 :
        Navigator.of(context).pop(true);
        break ;
      case 9 :
        Scaffold.of(_scaffoldContext).showSnackBar(
          SnackBar(
            content: Text("Mot de passe invalide."),
            duration: Duration(seconds: 2),
          ),
        );
        break ;
      default:
        showDummyErrorSnackBar(_scaffoldContext);
    }
  }
}