import 'package:flutter/material.dart';
import 'package:projet_b3/model/favorite.dart';

Widget    favoriteItem(context, Favorite favorite, {
  removeItem(Favorite favorite)
}) {

  double    _screenWidth = MediaQuery.of(context).size.width ;

  return Padding(
    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
    child: Dismissible(
      key: Key(UniqueKey().toString()),
      onDismissed: ((direction) {
        removeItem(favorite);
      }),
      direction: DismissDirection.startToEnd,
      background: Row(
        children: <Widget>[
          Image.asset("assets/trash.png"),
        ],
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                height: 150,
                width: double.maxFinite,
                child: Image.network(
                  favorite.imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: _screenWidth / 5,
                    height: _screenWidth / 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(favorite.imageUrl), // TODO
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5),),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          favorite.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                            "Bar a ${favorite.subtype}"
                        ),
                        Text(
                          favorite.address,
                        ),
                        Text(
                            "Ouvert jusqu'a 23h59"
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/favorite_full.png",
                          scale: 2,
                        ),
                        Text(
                          favorite.nbFav.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}