import 'package:flutter/material.dart';
import 'package:projet_b3/model/profile.dart';
import 'package:projet_b3/pages/page_edit_profile.dart';
import 'package:projet_b3/requests/profile_requests.dart';

class PageProfile extends StatefulWidget {
  PageProfile({Key key}) : super(key: key);

  @override
  _PageProfileState createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {

  Size              _screenSize ;
  BuildContext      _scaffoldContext ;

  Future<Profile>   _userProfileFuture ;
  Profile           _userProfile ;

  TextEditingController   _nameEditingController = TextEditingController() ;
  TextEditingController   _surnameEditingController = TextEditingController() ;
  TextEditingController   _emailEditingController = TextEditingController() ;

  @override
  void initState() {
    _userProfileFuture = getUserProfile() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mon profil".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
      ),
      body: FutureBuilder(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          _scaffoldContext = context ;
          if (snapshot.data != null) {
            _userProfile = snapshot.data as Profile ;
            return _profileBody() ;
          } else {
            return Center(
              child: SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget      _profileBody() {

    _nameEditingController.text = _userProfile.name ;
    _surnameEditingController.text = _userProfile.surname ;
    _emailEditingController.text = _userProfile.mail ;

    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: _screenSize.width / 2,
              height: _screenSize.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(_userProfile.picture).image,
                ),
              ),
            ),
            Text(
              "${_userProfile.surname} ${_userProfile.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            TextField(
              textAlign: TextAlign.center,
              controller: _nameEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            TextField(
              textAlign: TextAlign.center,
              controller: _surnameEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            TextField(
              textAlign: TextAlign.center,
              controller: _emailEditingController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30),),
            _editProfileButton(),
          ],
        ),
      ),
    );
  }

  Widget      _editProfileButton() {
    return ButtonTheme(
      /// Padding of parent avoid the button to touch screens borders
      minWidth: _screenSize.width,
      height: 50,
      child: FlatButton(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text("Modifier mon profil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => _goToEditProfile(),
      ),
    );
  }

  void      _goToEditProfile() async {
    final bool result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PageEditProfile(profile: _userProfile,)
      ),
    );
    if (result != null && result == true)
      Scaffold.of(_scaffoldContext).showSnackBar(
        SnackBar(
          content: Text("Votre profil a été modifié !"),
          duration: Duration(seconds: 2),
        ),
      );
    // TODO : Reload (get the user profile again)
    setState(() {
      _userProfileFuture = getUserProfile() ;
    });
  }

}