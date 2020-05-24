import 'package:flutter/material.dart';
import 'package:projet_b3/pages/page_bars.dart';
import 'package:projet_b3/pages/page_favorites.dart';
import 'package:projet_b3/pages/page_orders.dart';
import 'package:projet_b3/pages/page_settings.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int   _selectedPageIndex = 0 ;
  final _pagesList = [
    PageBars(),
    PageOrders(),
    PageFavorites(),
    PageSettings(),
  ] ;

  @override
  Widget build(BuildContext context) {
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
        _bottomNavigationBarItem('assets/home.png', "Bars"),
        _bottomNavigationBarItem('assets/orders.png', "Commandes"),
        _bottomNavigationBarItem('assets/favorites.png', "Favoris"),
        _bottomNavigationBarItem('assets/settings.png', "Parametres"),
      ],
      onTap: ((index) { _switchPage(index); }),
    );
  }

  /// Generate a BottomNavigationBarItem, given an IconData and a String.
  BottomNavigationBarItem _bottomNavigationBarItem(String imagePath, String title) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        imagePath,
        scale: 1.1,
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