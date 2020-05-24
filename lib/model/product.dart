class Product {

  Product(int id, String name, String description, int price, int sale,
      int newPrice, String type, {int quantity = 0}) {
    print("In default constructor ; json = $name");
    this.id = id ;
    this.name = name ;
    this.description = description ;
    this.price = price.toDouble() ;
    this.sale = sale.toDouble() ;
    this.newPrice = newPrice.toDouble() ;
    this.type = type ;
    this.quantity = quantity ;
  }

  factory Product.fromJson(Map<String, dynamic> jsonMap) {
    print("IN FACTORY : $jsonMap");
    print("Value of Id = ${jsonMap["Id"]}");
    print("Value of Name = ${jsonMap["Name"]}");
    print("Value of Description = ${jsonMap["Description"]}");
    print("Value of Price = ${jsonMap["Price"]}");
    print("Value of Sale = ${jsonMap["Sale"]}");
    print("Value of NewPrice = ${jsonMap["NewPrice"]}");
    print("Value of Type = ${jsonMap["Type"]}");
    return Product(
      jsonMap["Id"],
      jsonMap["Name"],
      jsonMap["Description"],
      jsonMap["Price"],
      jsonMap["Sale"],
      jsonMap["NewPrice"],
      jsonMap["Type"],
    );
  }

  int     id ;
  String  name ;
  String  description ;
  double  price ;
  double  sale ;
  double  newPrice ;
  String  type ;
  int     quantity;
}