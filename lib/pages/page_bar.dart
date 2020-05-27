import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/bar_info.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/bar_requests.dart';
import 'package:projet_b3/requests/favorite_requests.dart';
import 'package:projet_b3/views/bar_header.dart';
import 'package:projet_b3/views/product_item.dart';

class PageBar extends StatefulWidget {
  PageBar({Key key, this.bar}) : super(key: key);

  final Bar bar ;
  // TODO : Set bar id ; bar name & bar image instead

  @override
  _PageBarState createState() => _PageBarState();
}

class _PageBarState extends State<PageBar> {

  double    _screenWidth = 0 ;

  /// This is the list that the bar is selling. Static data for testing
  /// purposes.

  Future<BarInfo>         _barInfoFuture ;
  BarInfo                 _barInfo ;
  List<Product>           _cartContent = [] ;

  @override
  void initState() {
    print("In initState ; bar = ${widget.bar.name}");
    _barInfoFuture = getBarInfo(widget.bar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var   _bar = widget.bar ;

    _screenWidth = MediaQuery.of(context).size.width ;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(_bar.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  _bar.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: _offer(_bar),
      ),
      bottomSheet: InkWell(
        onTap: (_cartContent.isNotEmpty) ? () => _goToCart() : null,
        child: Container(
          width: _screenWidth,
          color: (_cartContent.isNotEmpty) ? Colors.deepOrange : Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Aller au panier".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Displays the section that handles the offers list.
  Widget _offer(Bar bar) {
    return FutureBuilder(
        future: _barInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            _barInfo = snapshot.data as BarInfo ;
            return Column(
              children: <Widget>[
                barHeader(bar, _screenWidth),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (() {
                              _favClicked(_barInfo) ;
                            }),
                            child: Image.asset(
                              (_barInfo.barDetails.isFavorite)
                                  ? "assets/favorite_full.png"
                                  : "assets/favorite_empty.png",
                              scale: 1.5,
                            ),
                          ),
                          Text(
                            _barInfo.barDetails.favorites.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(20),),
                (_barInfo.products.isNotEmpty)
                    ? _displayMenu()
                    : _noMenu(),
                Padding(padding: EdgeInsets.all(30),),
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }

  Widget  _noMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Cet etablissement ne propose aucun produit actuellement.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget  _displayMenu() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Text(
              "Menu".toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Flexible(
            fit: FlexFit.loose,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return productItem(
                        context,
                        _barInfo.products[index],
                        addToCart: (item) => _addToCart(item),
                        removeFromCart: (item) => _removeFromCart(item)
                    );
                  },
                    childCount: _barInfo.products.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TODO : Handle error
  void    _favClicked(BarInfo barInfo) {

    if (barInfo.barDetails.isFavorite) {
      removeFromFavorites(barInfo.barDetails.id).then((value) {
        if (value == "deleted")
          _updateFavoritesUI() ;
      });
    } else {
      addToFavorites(barInfo.barDetails.id).then((value) {
        if (value == "Added!")
          _updateFavoritesUI() ;
      });
    }
  }

  void    _updateFavoritesUI() {
    getBarInfo(widget.bar).then((value) {
      setState(() {
        _barInfo.barDetails.favorites = value.barDetails.favorites ;
        _barInfo.barDetails.isFavorite = value.barDetails.isFavorite ;
      });
    });
  }

  void    _addToCart(Product toAdd) {
    if (!_cartContent.contains(toAdd)) {
      toAdd.quantity = 1;
      setState(() {
        _cartContent.add(toAdd);
      });
    }
  }

  void    _removeFromCart(Product toRemove) {
    if (toRemove.quantity <= 1) {
      setState(() {
        _cartContent.remove(toRemove);
      });
    }
  }

  void      _goToCart() {
    print("__________ GOING TO CART __________");
    _cartContent.forEach((element) {
      print("ELEMENT ${element.name} X ${element.quantity}");
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PageCart(cartContent: _cartContent, bar: widget.bar,),
      ),
    );
  }

/*
  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: _screenWidth / 4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.network("https://s1.qwant.com/thumbr/0x380/3/9/60c4de7be57ee1b7d24d07dde941c3027588bc313699cba9ef9ef8fb6c7fda/1280px-Hard_Rock_Cafe_Logo.svg.png?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F2%2F2c%2FHard_Rock_Cafe_Logo.svg%2F1280px-Hard_Rock_Cafe_Logo.svg.png&q=0&b=1&p=0&a=1").image
                  )
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bar.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Bar category" + " - " + "Bar address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Opening hours" + " - " + "01.12.12.12.12",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Happy Hour de 20h a 23h",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),

        Image.asset("assets/favorite_empty.png"),
        Padding(padding: EdgeInsets.all(20),),
        Center(
          child: Text(
            "Menu".toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _productsList.length,
          itemBuilder: (context, i) {
            return productItem(context, _productsList[i]);
          },
        ),
      ],
    )
   */

}