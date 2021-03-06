import 'package:flutter/material.dart';
import 'package:projet_b3/model/favorite.dart';
import 'package:projet_b3/requests/favorite_requests.dart';
import 'package:projet_b3/requests/utils.dart';
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

    if (_favoritesList.length == 0) {
      return Center(
        child: Text(
          "Aucun favori pour l'instant !"
        ),
      );
    }
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

    removeFromFavorites(_favoritesList[toRemoveIndex].id).then((value) {
      Favorite toDeleteItem = _favoritesList[toRemoveIndex] ;
      setState(() {
        _favoritesList.removeAt(toRemoveIndex);
      });
      if (value[0] != SERVER_RESPONSE_NO_ERROR) {
        setState(() {
          _favoritesList.insert(toRemoveIndex, toDeleteItem);
        });
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(getServerErrorMessage(value[0])),),
        );
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Le bar a été supprimé de votre liste de favoris."),)
        );
      }
    });
  }
}