import 'package:flutter/material.dart';

class PageFavorites extends StatefulWidget {
  PageFavorites({Key key}) : super(key: key);

  @override
  _PageFavoritesState createState() => _PageFavoritesState();
}

class _PageFavoritesState extends State<PageFavorites> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorites"),
      ),
      body: new Center(

      ),
    );
  }
}