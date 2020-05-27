import 'package:flutter/material.dart';
import 'package:projet_b3/pages/page_bars.dart';
import 'package:projet_b3/pages/page_favorites.dart';
import 'package:projet_b3/pages/page_orders.dart';
import 'package:projet_b3/pages/page_settings.dart';
import 'package:projet_b3/singleton.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.selectedPageDefault = 0}) : super(key: key);

  final int   selectedPageDefault ;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int     _selectedPageIndex = 0 ;
  double  _screenWidth = 0 ;
  final   _pagesList = [
    PageBars(),
    PageOrders(),
    PageFavorites(),
    PageSettings(),
  ] ;

  @override
  Widget build(BuildContext context) {

    _selectedPageIndex = widget.selectedPageDefault ;
    _screenWidth = MediaQuery.of(context).size.width ;
    print("SCREEN WIDTH = $_screenWidth");
    var singletonInstance = Singleton.instance ;
    print("SINGLETON HASH == ${singletonInstance.hashKey}");

    return Scaffold(
      body: _pagesList[_selectedPageIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  /// Generates our Bottom Navigation Bar.
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedPageIndex,
      items: [
        _bottomNavigationBarItem('assets/home_empty.png', 'assets/home_full.png', "Bars"),
        _bottomNavigationBarItem('assets/orders_empty.png', 'assets/orders_full.png', "Commandes"),
        _bottomNavigationBarItem('assets/favorite_empty.png', 'assets/favorite_full.png', "Favoris"),
        _bottomNavigationBarItem('assets/settings_empty.png', 'assets/settings_full.png', "Parametres"),
      ],
      onTap: ((index) { _switchPage(index); }),
    );
  }

  /// Generate a BottomNavigationBarItem, given an IconData and a String.
  BottomNavigationBarItem _bottomNavigationBarItem(String iconPath,
      String activeIconPath, String title) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          width: _screenWidth / 12,
          height: _screenWidth / 12,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: Image.asset(
                activeIconPath,
              ).image,
            ),
          ),
        ),
      ),
      icon: Container(
        width: _screenWidth / 15,
        height: _screenWidth / 15,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: Image.asset(
              iconPath,
            ).image,
          ),
        ),
      ),
      title: Text(""),
    );
  }

  /// When the user switch to another page, this is triggered to change the
  /// selectedPageIndex.
  void _switchPage(int index) {
    setState(() {
      _selectedPageIndex = index ;
    });
  }
}