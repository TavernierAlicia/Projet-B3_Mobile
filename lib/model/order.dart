import 'package:projet_b3/model/bar.dart';

class Order {

  Order(int id, int establishmentId, String establishmentName,
      String pictureUrl, String date, double totalPrice, String status,
      List<OrderItem> orderItems,) {

    print("DEFAULT CONSTRUCTOR ID = $id");
    this.id = id ;
    this.establishmentId = establishmentId ;
    this.establishmentName = establishmentName ;
    this.pictureUrl = pictureUrl ;
    this.date = date ;
    this.totalPrice = totalPrice.toDouble() ;
    this.status = status ;
    this.orderItems = orderItems ;
  }

  Order.details(int id, int establishmentId, String establishmentName,
      String pictureUrl, String date, double totalPrice, String status,
      List<OrderItem> orderItems, int establishmentStreetNum,
      String establishmentStreetName, String establishmentCity) {
    this.establishmentStreetNum = establishmentStreetNum ;
    this.establishmentStreetName = establishmentStreetName ;
    this.establishmentCity = establishmentCity ;
    this.id = id ;
    this.establishmentId = establishmentId ;
    this.establishmentName = establishmentName ;
    this.pictureUrl = pictureUrl ;
    this.date = date ;
    this.totalPrice = totalPrice.toDouble() ;
    this.status = status ;
    this.orderItems = orderItems ;
  }

  factory Order.fromJson(Map<String, dynamic> jsonMap) {

    List<OrderItem>   _orderItems = [] ;

    var commandItems = jsonMap["CmdItems"] as List ;
    _orderItems =
        commandItems.map<OrderItem>((json) => OrderItem.fromJson(json))
            .toList();

    print("ORDER ITEM PARSING OVER");
    _orderItems.forEach((element) {
      print("NEW ORDER ITEM : ${element.name}");
    });

    var command = jsonMap["Cmd"] ;

    return Order(
      command["Id"],
      command["Etab_id"],
      command["Etab_name"],
      command["Pic"],
      command["Date"],
      double.tryParse(command["Price"].toString()),
      command["Status"],
      _orderItems,
    );
  }

  factory   Order.detailsFromJson(Map<String, dynamic> jsonMap) {
    List<OrderItem>   _orderItems = [] ;

    print("Order.detailsFromJson");

    var commandItems = jsonMap["CmdItems"] as List ;
    _orderItems =
        commandItems.map<OrderItem>((json) => OrderItem.fromJson(json))
            .toList();

    print("ORDER ITEM PARSING OVER");
    _orderItems.forEach((element) {
      print("NEW ORDER ITEM : ${element.name}");
    });

    var command = jsonMap["Cmd"] ;

    return Order.details(
      command["Id"],
      command["Etab_id"],
      command["Etab_name"],
      command["Pic"],
      command["Date"],
      double.tryParse(command["Price"].toString()),
      command["Status"],
      _orderItems,
      command["EtabStreetNum"],
      command["EtabStreetName"],
      command["EtabCity"],
    );
  }

  int             id ;
  int             establishmentId ;
  String          establishmentName ;
  String          pictureUrl ;
  String          date ;
  double          totalPrice ;
  String          status ;
  List<OrderItem> orderItems ;
  int             establishmentStreetNum ;
  String          establishmentStreetName ;
  String          establishmentCity ;
}

class   OrderItem {

  OrderItem(int itemId, int commandId, int quantity, String name, double price){
    this.itemId = itemId ;
    this.commandId = commandId ;
    this.quantity = quantity ;
    this.name = name ;
    this.price = price ;
  }

  factory OrderItem.fromJson(Map<String, dynamic> jsonMap) {

    print("In orderItem factory ; jsonMap = $jsonMap");

    return OrderItem(
      jsonMap["Item_id"],
      jsonMap["CommandId"],
      jsonMap["Quantity"],
      jsonMap["Name"],
      double.tryParse(jsonMap["Price"].toString()),
    );
  }

  int     itemId ;
  int     commandId ;
  int     quantity ;
  String  name ;
  double  price ;
}