import 'package:projet_b3/model/bar.dart';

class Order {

  Order(int id, String establishmentName, String pictureUrl, String date,
      double totalPrice, String status, List<OrderItem> orderItems) {

    this.id = id ;
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
    _orderItems = commandItems.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();

    print("ORDER ITEM PARSING OVER");
    _orderItems.forEach((element) {
      print("NEW ORDER ITEM : ${element.name}");
    });

    var command = jsonMap["Cmd"] ;

    return Order(
      command["Id"],
      command["Etab_name"],
      command["Pic"],
      command["Date"],
      double.tryParse(command["Price"].toString()),
      command["Status"],
      _orderItems,
    );
  }

  int             id ;
  String          establishmentName ;
  String          pictureUrl ;
  String          date ;
  double          totalPrice ;
  String          status ;
  List<OrderItem> orderItems ;
}

class   OrderItem {

  OrderItem(int commandId, int quantity, String name, double price) {
    this.commandId = commandId ;
    this.quantity = quantity ;
    this.name = name ;
    this.price = price ;
  }

  factory OrderItem.fromJson(Map<String, dynamic> jsonMap) {

    print("In orderItem factory ; jsonMap = $jsonMap");

    return OrderItem(
      jsonMap["CommandId"],
      jsonMap["Quantity"],
      jsonMap["Name"],
      double.tryParse(jsonMap["Price"].toString()),
    );
  }

  int     commandId ;
  int     quantity ;
  String  name ;
  double  price ;
}