import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/filter.dart';
import 'package:projet_b3/pages/page_bar.dart';
import 'package:projet_b3/requests/bar_requests.dart';
import 'package:projet_b3/views/bar_item.dart';
import 'package:projet_b3/views/filter_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PageBars extends StatefulWidget {
  PageBars({Key key}) : super(key: key);

  @override
  _PageBarsState createState() => _PageBarsState();
}

class _PageBarsState extends State<PageBars> {

  Permission                      _accessPosition = Permission.locationAlways ;

  /// Map variables
  GoogleMapController             _mapController ;
  Geolocator                      _geoLocator = Geolocator();
  Position                        _userLocation ;
  List<Marker>                    _markers = [] ;
  Set<Marker>                     _markersSet = Set() ;

  Future<List<Bar>>               _barsList ;

  static List   _barTypes = [
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

  static List   _barPopularity = [
    Filter('Tous', true),
    Filter('Nouveaute', false),
    Filter('Les plus likés', false),
  ];

  static List   _barDistance = [
    Filter("Tous", false),
    Filter("Proches", true),
  ];

  /// Text search variables
  final               _searchBarController = TextEditingController() ;
  Future<List<Bar>>   _searchResultsFuture ;
  bool                _isSearchEnabled = false ;

  Filter  _filtersSelectedType = _barTypes[0] ;
  Filter  _filtersSelectedPopularity = _barPopularity[0] ;
  Filter  _filtersSelectedDistance = _barDistance[0] ;

  Size          _screenSize ;

  @override
  void initState() {
    print("In initState");
    _barsList = getBarsList();
    _accessPosition.isGranted.then((value) {
      print("Permission = $value");
      if (!value) {
        _getPermissions();
      } else {
//        _getLocation();
        _waitForLocation();
      }
    });
    super.initState();
  }

  void    _getPermissions() async {
    await Permission.location.request().then((value) {
      print("PERMISSION RESPONSE = $value");
      if (value == PermissionStatus.granted) {
//        _getLocation();
        _waitForLocation();
      }
      // TODO : Handle no+
    }) ;
  }

  void                _getLocation() {
    _geoLocator.getPositionStream(
      LocationOptions(
        accuracy: LocationAccuracy.best,
        timeInterval: 1000,
      ),
    ).listen((event) {
      // TODO : Uncomment following when not in debug
      /*
      setState(() {
        // TODO : This might cause memory leaks
        print("New location : $event");
        _userLocation = event ;
      });*/
    });
  }

  Future<Position>    _waitForLocation() async {
    var currentLocation ;
    try {
      print("IN TRY : WAITING FOR LOCATION");
      currentLocation = await _geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).timeout(
          Duration(milliseconds: 5000),
          onTimeout: () {
            print("Time out triggered.");
            setState(() {
              _userLocation = Position(
                latitude: 48.8534100,
                longitude: 2.3488000,
              );
            });
            return _userLocation;
          }
      );
    } catch (e) {
      print("CATCHING ERROR : $e");
      currentLocation = null ;
    }
    _userLocation = currentLocation ;
    return currentLocation ;
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size ;

    _barsList.then((value) {
      _markers = _markersGenerator(value) ;
      _markersSet = Set.from(_markers) ;
    });

    return Scaffold(
      body: FutureBuilder(
        future: _waitForLocation(),
        builder: (context, snapshot) {
          return (snapshot.data != null) ?
          Stack(
              children: <Widget>[
                _displayMap(),
                _searchBar(),
                Positioned(
                  top: 110,
                  left: 20,
                  child: _setFilters(),
                ),
                /*(_isSearchEnabled)
                    ? Positioned(
                  bottom: 5,
                  left: 5,
                  right: 5,
                  child: _displaySearchResults(),
                )
                    : Wrap(
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                    )
                  ],
                ),*/
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
      bottomSheet: (_isSearchEnabled) ? _displaySearchResults() : null,
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
          print(_filtersSelectedDistance.name) ;
          print(_filtersSelectedPopularity.name) ;
          print(_filtersSelectedType.name) ;
          _performSearchByFilters();
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
            _filtersSelectedType = _barTypes[0];
            dialogSetState(() {
              _filtersSelectedType = type;
            });
          }),
          child: filterItem(type, _filtersSelectedType == type),
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
      childAspectRatio: 5,
      shrinkWrap: true,
      children: _barPopularity.map((popularity) {
        return GestureDetector(
          onTap: (() {
            _filtersSelectedPopularity = _barPopularity[0];
            dialogSetState(() {
              _filtersSelectedPopularity = popularity;
            });
          }),
          child: filterItem(popularity, _filtersSelectedPopularity == popularity),
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
      childAspectRatio: 4,
      shrinkWrap: true,
      children: _barDistance.map((distance) {
        return GestureDetector(
          onTap: (() {
            _filtersSelectedDistance = _barDistance[0];
            dialogSetState(() {
              _filtersSelectedDistance = distance;
            });
          }),
          child: filterItem(distance, _filtersSelectedDistance == distance),
        );
      }).toList(),
    );
  }

  Widget          _centerMap() {
    return GestureDetector(
      onTap: (() {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(_userLocation.latitude, _userLocation.longitude),
            15,
          ),
        );
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
    return Wrap(
      children: <Widget>[
        Container(
          width: _screenSize.width,
          height: _screenSize.height - 80 ,
          child: GoogleMap(
            mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {
              print("Map is created");
              setState(() {
                print("in setState");
                _mapController = controller ;
                _mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(_userLocation.latitude, _userLocation.longitude),
                    15,
                  ),
                );
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(_userLocation.latitude, _userLocation.longitude),
            ),
            markers: _markersSet,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),
        )
      ],
    );
  }

  /// Handles the search when the user submits his search or hit the search
  /// button.
  void            _performSearch() {
    print("Should perform search about ${_searchBarController.text}");
    String search = _searchBarController.text ;

    if (search.isNotEmpty)
      setState(() {
        _searchResultsFuture = searchBars(search);
        _isSearchEnabled = true ;
      });
    _searchResultsFuture.then((value) {
      print("Search results future finished");
      _markers = _markersGenerator(value);
      _markersSet = Set.of(_markers);
    });
  }

  void            _performSearchByFilters() {
    bool needsLocation = _filtersSelectedDistance != _barDistance[0] ;
    setState(() {
      _searchResultsFuture = searchBarsByFilters(
        type: (_filtersSelectedType != _barTypes[0]) ? _filtersSelectedType.name : "",
        popularity: (_filtersSelectedPopularity != _barPopularity[0]) ? ((_filtersSelectedPopularity != _barPopularity[1]) ? "fav" : "new") : "",
        distance: (_filtersSelectedDistance != _barDistance[0]) ? "1" : "",
        lat: (needsLocation) ? _userLocation.latitude.toString() : "",
        long: (needsLocation) ? _userLocation.longitude.toString() : "",
      ) ;
      _isSearchEnabled = true ;
    });
    _searchResultsFuture.then((value) {
      _markers = _markersGenerator(value) ;
      _markersSet = Set.of(_markers) ;
    });
  }

  Widget          _displaySearchResults() {

    return FutureBuilder(
      future: _searchResultsFuture,
      builder: ((searchContext, snapshot) {

        print("Building searchResults");
        if (snapshot.hasData) {
          return SizedBox(
            height: 150, // card height
            width: _screenSize.width,
            child: Stack(
              children: <Widget>[
                ((snapshot.data as List<Bar>).length > 0) ?
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (snapshot.data as List<Bar>).length,
                  itemBuilder: (context, index) {
                    print("ITEM = ${(snapshot.data as List<Bar>)[index].name}");
                    return  barItem(context, (snapshot.data as List<Bar>)[index]);
                  },
                ) : Center(
                  child: Text(
                    "Aucun resultat !",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: (() {
                      var futureBar = getBarsList();
                      futureBar.then((value) {
                        _markers = _markersGenerator(value);
                        _markersSet = Set.of(_markers);
                        setState(() {
                          _isSearchEnabled = false ;
                          _barsList = futureBar ;
                        });
                      });
                      _searchBarController.clear();
                      _filtersSelectedType = _barTypes[0] ;
                      _filtersSelectedPopularity = _barPopularity[0] ;
                      _filtersSelectedDistance = _barDistance[0] ;
                    }),
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  /// Builds a list of Marker objects, given the bars list.
  List<Marker>   _markersGenerator(List<Bar> barsList) {

    List<Marker> result = [] ;
    var markerImage ;

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/location_pin.png",
    ).then((value) => markerImage = value );

    barsList.forEach((element) {
      result.add(
        Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: element.coordinates,
            icon: markerImage,
            onTap: (() {
              print("Clicked on ${element.name}");
              _mapController.animateCamera(
                CameraUpdate.newLatLng(
                  element.coordinates,
                ),
              );
              _showBarPreview(element);
            })
        ),
      );
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

/*  List<Marker>    _markersGenerator(List<Bar> barsList) {
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
  } */
}