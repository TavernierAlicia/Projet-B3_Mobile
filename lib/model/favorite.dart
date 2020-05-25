class Favorite {

  Favorite(int id, String name, String type, String subtype, String address,
      String imageUrl, String date, int nbFav) {
    this.id = id ;
    this.name = name ;
    this.type = type ;
    this.subtype = subtype ;
    this.address = address ;
    this.imageUrl = imageUrl ;
    this.date = date ;
    this.nbFav = nbFav ;
  }

  factory Favorite.fromJson(Map<String, dynamic> jsonMap) {
    return Favorite(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Type"],
      jsonMap["Subtype"],
      "${jsonMap["Street_num"]} ${jsonMap["Street_name"]}",
      jsonMap["Pic"],
      jsonMap["DateAdded"],
      jsonMap["NbFavs"],
    );
  }

  int     id ;
  String  name ;
  String  type ;
  String  subtype ;
  String  address ;
  String  imageUrl ;
  String  date ;
  int     nbFav ;
}