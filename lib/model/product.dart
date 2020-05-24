class Product {

  Product(String name, String description, double price, bool available,
      {int quantity = 0}) {
    this.name = name ;
    this.description = description ;
    this.price = price ;
    this.available = available ;
    this.quantity = quantity;
  }

  String  name ;
  String  description ;
  double  price ;
  bool    available ;
  int     quantity;

}