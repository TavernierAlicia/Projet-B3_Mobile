import 'package:flutter/material.dart';
import 'package:projet_b3/model/favorite.dart';
import 'package:projet_b3/requests/favorite_requests.dart';
import 'package:projet_b3/views/favorite_item.dart';

class PageFavorites extends StatefulWidget {
  PageFavorites({Key key}) : super(key: key);

  @override
  _PageFavoritesState createState() => _PageFavoritesState();
}

class _PageFavoritesState extends State<PageFavorites> {

  Future<List<Favorite>>    _favoritesList ;

  @override
  void initState() {
    _favoritesList = getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Mes bars favoris".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _favoritesList,
        builder: (context, snapshot) {
          return (snapshot.data != null)
              ? _favorites(snapshot.data as List<Favorite>)
              : Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget    _favorites(List<Favorite> favorites) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: favorites.length,
      itemBuilder: (context, i) {
        return favoriteItem(context, favorites[i]);
      },
    );
  }
}