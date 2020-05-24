import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/filter.dart';
import 'package:projet_b3/pages/page_bar.dart';
import 'package:projet_b3/requests/bar_requests.dart';
import 'package:projet_b3/views/filter_item.dart';

class PageBars extends StatefulWidget {
  PageBars({Key key}) : super(key: key);

  @override
  _PageBarsState createState() => _PageBarsState();
}

class _PageBarsState extends State<PageBars> {

  final         _searchBarController = TextEditingController() ;

  // TODO : Test purposes only ; replace with a Future that retrieve bars.
  Future<List<Bar>>   _barsList ;

  List         _barTypes = [
    Filter('Tous', true),
    Filter('Bar a vins', false),
    Filter('Tapas', false),
    Filter('Rhum', false),
    Filter('Vodka', false),
    Filter('Tequila', false),
    Filter('Cocktail', false),
    Filter('Chicha', false),
    Filter('Whiskey', false),
  ];

  List        _barPopularity = [
    Filter('Tous', true),
    Filter('Nouveaute', false),
    Filter('Les plus likes', false),
  ];

  List        _barDistance = [
    Filter("Proches", true),
    Filter("Tous", false),
  ];

  // TODO : No need to create a list
  List<Filter>  _filtersSelectedType = [] ;
  List<Filter>  _filtersSelectedPopularity = [] ;
  List<Filter>  _filtersSelectedDistance = [] ;

  List<Marker>  _markers = [];

  LatLng        _mapCenter = LatLng(51.5, -0.09) ;
  double        _mapZoom = 5.0 ;

  @override
  void initState() {
    print("In initState");
    _barsList = getBarsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _barsList.then((value) => _markers = _markersGenerator(value));

    return Scaffold(
      body: FutureBuilder(
        future: _barsList,
        builder: (context, snapshot) {
          return (snapshot.data != null) ?
          Stack(
              children: <Widget>[
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    _displayMap()
                  ],
                ),
                _searchBar(),
                Positioned(
                  top: 110,
                  left: 20,
                  child: _setFilters(),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _centerMap(),
                ),
              ]
          )
              : Center(
            child: SizedBox(
              width: 75,
              height: 75,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  Widget          _setFilters() {
    return GestureDetector(
      onTap: (() {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (dialogContext) {
              return StatefulBuilder(
                builder: (dialogContext, dialogSetState) {
                  return AlertDialog(
                      content: SingleChildScrollView(
                        child: Container(
                          width: double.maxFinite,
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                "Type de bar".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              _filtersBarType(dialogSetState),
                              Text(
                                "Popularite".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              _filtersBarPopularity(dialogSetState),
                              Text(
                                "Distance".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              _filtersBarDistance(dialogSetState),
                            ],
                          ),
                        ),
                      )
                  );
                },
              );
            }
        ).then((todo) {
          print("Dialog dismissed ; do stuff");
          // TODO - Used when dialog is dismissed - Reload markers on the map
        });
      }),
      child: Image.asset("assets/filters.png"),
    );
  }

  Widget          _filtersBarType(dialogSetState) {
    return GridView.count(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      crossAxisCount: 3,    // Number of columns
      crossAxisSpacing: 4,  // Space between lines
      mainAxisSpacing: 4,   // Space between columns
      childAspectRatio: 3,
      shrinkWrap: true,
      children: _barTypes.map((type) {
        return GestureDetector(
          onTap: (() {
            _filtersSelectedType.clear();
            dialogSetState(() {
              _filtersSelectedType.add(type);
            });
          }),
          child: filterItem(type, _filtersSelectedType.contains(type)),
        );
      }).toList(),
    );
  }

  Widget          _filtersBarPopularity(dialogSetState) {
    return GridView.count(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
      crossAxisCount: 1,    // Number of columns
      crossAxisSpacing: 4,  // Space between lines
      mainAxisSpacing: 4,   // Space between columns
      childAspectRatio: 9,
      shrinkWrap: true,
      children: _barPopularity.map((popularity) {
        return GestureDetector(
          onTap: (() {
            _filtersSelectedPopularity.clear();
            dialogSetState(() {
              _filtersSelectedPopularity.add(popularity);
            });
          }),
          child: filterItem(popularity, _filtersSelectedPopularity.contains(popularity)),
        );
      }).toList(),
    );
  }

  Widget          _filtersBarDistance(dialogSetState) {
    return GridView.count(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      crossAxisCount: 2,    // Number of columns
      crossAxisSpacing: 20,  // Space between lines
      mainAxisSpacing: 4,   // Space between columns
      childAspectRatio: 5,
      shrinkWrap: true,
      children: _barDistance.map((distance) {
        return GestureDetector(
          onTap: (() {
            _filtersSelectedDistance.clear();
            dialogSetState(() {
              _filtersSelectedDistance.add(distance);
            });
          }),
          child: filterItem(distance, _filtersSelectedDistance.contains(distance)),
        );
      }).toList(),
    );
  }

  Widget          _centerMap() {
    return GestureDetector(
      onTap: (() {
        print("Should recenter map");
        // TODO
      }),
      child: Image.asset("assets/recenter.png"),
    );
  }

  /// Handles the search bar.
  Widget          _searchBar() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
        child: Wrap(
          children: <Widget>[
            Text(
              "Chercher un bar".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Chercher un bar",
                    ),
                    controller: _searchBarController,
                    onSubmitted: ((_) { _performSearch() ; }),
                  ),
                ),
                GestureDetector(
                  onTap: (() { _performSearch() ; }),
                  child: Image.asset(
                    'assets/search.png',
                    scale: 1.5,
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  /// Handles the map display.
  /// We are using Open Street Map, as this is a free to use API.
  Widget          _displayMap() {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: _mapCenter,
          zoom: _mapZoom,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(markers: _markers)
        ],
      ),
    );
  }

  /// Handles the search when the user submits his search or hit the search
  /// button.
  void            _performSearch() {
    print("Should perform search about ${_searchBarController.text}");
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Feature not implemented yet."),
        )
    );
    // TODO
  }

  /// Builds a list of Marker objects, given the bars list.
  List<Marker>    _markersGenerator(List<Bar> barsList) {
    List<Marker> result = [];

    barsList.forEach((element) {
      result.add(Marker(
        width: 50,
        height: 50,
        point: LatLng(element.coordinates.latitude, element.coordinates.longitude),
        builder: (context) => Container(
          child: GestureDetector(
            child: Image.asset(
              'assets/location_pin.png',
              scale: 1.50,
            ),
            onTap: (() {
              print("Clicked on ${element.name}");
              _showBarPreview(element);
              setState(() {
                // FIXME : Does not seems to work...
                _mapCenter = element.coordinates ;
                _mapZoom = 10 ;
              });
            }),
          ),
        ),
      ));
    });
    return result ;
  }

  void          _showBarPreview(Bar bar) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            content: Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            bar.imageUrl,
                          ),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10),),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bar.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text("Bar a ${bar.subtype}"),
                          Text("Ouvert jusqu'a 23h59"),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10),),
                InkWell(
                  onTap: (() {
                    print("Clicked !");
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageBar(bar: bar),
                      ),
                    );
                  }),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(17),
                      child: Text(
                        "Acceder a la carte",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

}