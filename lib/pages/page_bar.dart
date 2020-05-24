import 'package:flutter/material.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/views/bar_header.dart';
import 'package:projet_b3/views/product_item.dart';

class PageBar extends StatefulWidget {
  PageBar({Key key, this.bar}) : super(key: key);

  final Bar bar ;

  @override
  _PageBarState createState() => _PageBarState();
}

class _PageBarState extends State<PageBar> {

  double    _screenWidth = 0 ;

  /// This is the list that the bar is selling. Static data for testing
  /// purposes.
  var _productsList = [
    Product("Mojito", "Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime Mint & lime", 10.0, true),
    Product("Punch", "Mint & lime", 10.0, true),
    Product("Unavailable Product", "", 10.0, false),
    Product("Pina Colada", "Mint & lime", 10.0, true),
    Product("Margarita", "Mint & lime", 10.0, true),
    Product("Caipirinha", "Mint & lime", 10.0, true),
    Product("Blue Lagoon", "Mint & lime", 10.0, true),
    Product("Sex on the beach", "Mint & lime", 10.0, true),
    Product("Long Island", "Mint & lime", 10.0, true),
    Product("Bloody Mary", "Mint & lime", 10.0, true),
  ] ;

  List<Product> _cartContent = [] ;

  @override
  Widget build(BuildContext context) {

    var _bar = widget.bar ;

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
                    "https://s1.qwant.com/thumbr/0x380/1/2/2a39f1f558f2cbbec11a08e43493bde861d612add6be643dbc5ad6fe0b16fc/BDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg?u=https%3A%2F%2Fimages.bwwstatic.com%2Fcolumnpic6%2FBDBE5B56-B1B4-586D-27C8A70A4A54E50A.jpg&q=0&b=1&p=0&a=1",
                    fit: BoxFit.cover,
                  )),
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
    return Column(
      children: <Widget>[
        barHeader(bar, _screenWidth),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (() {
                    // TODO : Add bar to favorites
                  }),
                  child: Image.asset(
                    "assets/favorites.png",
                    scale: 1.5,
                  ),
                ),
                Text("1234")
              ],
            )
          ],
        ),*/
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
        Flexible(
          fit: FlexFit.loose,
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return productItem(
                      context,
                      _productsList[index],
                      addToCart: (item) => _addToCart(item),
                      removeFromCart: (item) => _removeFromCart(item)
                  );
                },
                  childCount: _productsList.length,
                ),
              ),
            ],
          ),
        )
      ],
    );
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

        Image.asset("assets/favorites.png"),
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