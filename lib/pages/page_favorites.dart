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

  Future<List<Favorite>>    _favoritesListFuture ;
  List<Favorite>            _favoritesList = [] ;

  @override
  void initState() {
    _favoritesListFuture = getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _favoritesListFuture.then((value) {
        _favoritesList = value ;
    }) ;

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
        future: _favoritesListFuture,
        builder: (context, snapshot) {
          return (snapshot.data != null)
              ? _favorites()
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

  Widget    _favorites() {

    _favoritesList.forEach((element) {
      print("Favorites list ; ELEMENT = ${element.id}");
    });
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _favoritesList.length,
      itemBuilder: (context, i) {
        return favoriteItem(
          context,
          _favoritesList[i],
          removeItem: (item) => this._removeFromFavorites(i),
        );
      },
    );
  }

  void    _removeFromFavorites(int toRemoveIndex) {
    print("In _removeFromFavorites ; SHOULD REMOVE $toRemoveIndex");
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("OK"),)
    );
    _favoritesList.forEach((element) {
      print("BEFORE DELETE ; ELEMENT = ${element.date}");
    });
    setState(() {
      _favoritesList.removeAt(toRemoveIndex);
    });
    _favoritesList.forEach((element) {
      print("AFTER DELETE ; ELEMENT = ${element.date}");
    });
    // TODO : Call server to remove fav
  }
}