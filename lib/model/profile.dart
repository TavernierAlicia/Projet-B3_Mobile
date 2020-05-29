class Profile {

  Profile(int id, String name, String surname, String mail, String picture,
      String birth) {
    this.id = id ;
    this.name = name ;
    this.surname = surname ;
    this.mail = mail ;
    this.picture = picture ;
    this.birth = birth ;
  }

  factory Profile.fromJson(Map<String, dynamic> jsonMap) {
    return Profile(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Surname"],
      jsonMap["Mail"],
      jsonMap["Pic"],
      jsonMap["Birth"]
    );
  }

  int       id ;
  String    name ;
  String    surname ;
  String    mail ;
  String    picture ;
  String    birth ;
}