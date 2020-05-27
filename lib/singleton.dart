class Singleton {
  static final Singleton  _singleton = Singleton._internal() ;

  factory Singleton() {
    return _singleton ;
  }

  Singleton._internal() ;

  static Singleton get instance => _singleton ;

  String    hashKey ;
}