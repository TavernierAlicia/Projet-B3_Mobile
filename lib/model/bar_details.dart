class BarDetails {

  BarDetails(int id, String name, String description, int favorites,
      int streetNumber, String streetName, String complement, String city,
      String zip, String type, String subtype, String imageUrl, String date,
      String open, String happyHourStart, String happyHourEnd,
      bool isFavorite) {
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.favorites = favorites ;
    this.streetNumber = streetNumber ;
    this.streetName = streetName ;
    this.complement = complement ;
    this.city = city ;
    this.zip = zip ;
    this.type = type ;
    this.subtype = subtype ;
    this.imageUrl = imageUrl ;
    this.date = date ;
    this.open = open ;
    this.happyHourStart = happyHourStart ;
    this.happyHourEnd = happyHourEnd ;
    this.isFavorite = isFavorite ;
  }

  factory BarDetails.fromJson(Map<String, dynamic> json) {

    return BarDetails(
      json["Id"],
      json["Name"],
      json["Description"],
      json["Favs"],
      json["Street_num"],
      json["Street_name"],
      json["Complement"],
      json["City"],
      json["Zip"],
      json["Type"],
      json["Subtype"],
      json["Pic"],
      json["Date"],
      json["Open"],
      json["HH"],
      json["HHEnd"],
      json["IsFav"],
    );
  }

  int             id ;
  String          name ;
  String          description ;
  int             favorites ;
  int             streetNumber ;
  String          streetName ;
  String          complement ;
  String          city ;
  String          zip ;
  String          type ;
  String          subtype ;
  String          imageUrl ;
  String          date ;
  String          open ;
  String          happyHourStart ;
  String          happyHourEnd ;
  bool            isFavorite ;
}