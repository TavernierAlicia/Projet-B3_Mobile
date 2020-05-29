import 'package:flutter/material.dart';
import 'package:projet_b3/model/profile.dart';
import 'package:projet_b3/utils.dart';
import 'package:projet_b3/views/form_item.dart';

class PageEditProfile extends StatefulWidget {
  PageEditProfile({Key key, this.profile}) : super(key: key);

  final Profile profile ;

  @override
  _PageEditProfileState createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {

  Size            _screenSize ;
  BuildContext    _scaffoldContext ;

  TextEditingController   _nameEditingController = TextEditingController();
  TextEditingController   _surnameEditingController = TextEditingController();
  TextEditingController   _emailEditingController = TextEditingController();
  TextEditingController   _passwordEditingController = TextEditingController();
  TextEditingController   _newPasswordEditingController = TextEditingController();
  // TODO : Birth edit

  Profile         _profile ;

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;
    _profile = widget.profile ;

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


    _nameEditingController.value = TextEditingValue(text: _profile.name) ;
    _nameEditingController.selection = TextSelection.collapsed(offset: _profile.name.length);

    _surnameEditingController.text = _profile.surname ;
    _emailEditingController.text = _profile.mail ;

    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Center(
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
            TextFormField(
              controller: _nameEditingController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onFieldSubmitted: ((v) {
                FocusScope.of(context).nextFocus();
              }),
            ),
          ],
        ),
      ),
    );
  }
}