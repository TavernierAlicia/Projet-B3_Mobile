
import 'package:projet_b3/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saves the user [token] in the SharedPreferences and in a Singleton.
Future<Null>  saveUserToken(String token) async {
  SharedPreferences   prefs = await SharedPreferences.getInstance() ;
  prefs.setString("AUTHORIZATION", token);

  var singletonInstance = Singleton.instance ;
  singletonInstance.hashKey = token ;
}