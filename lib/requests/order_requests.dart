
import 'package:projet_b3/model/bar.dart';
import 'package:projet_b3/model/product.dart';
import 'package:projet_b3/pages/page_cart.dart';
import 'package:projet_b3/requests/utils.dart';
import 'package:http/http.dart';

Future<String>  takeOrder(Bar bar, List<Product> cartContent, int arrivingIn,
    PaymentMethod paymentMethod) async {
  String                url = BASE_URL + "takeOrder" ;
  Map<String, String>   headers = {
    "Authorization" : "dcdb199e-2797-4041-8b26-08bc451dd47b"
  } ;

  List<int> products = [] ;
  cartContent.forEach((element) {
    for (var i = 0 ; i < element.quantity ; i++) {
      products.add(element.id);
    }
  });

  String    arrivingInString = "00:";
  if (arrivingIn == 0) arrivingInString += "00";
  else arrivingInString += arrivingIn.toString() ;

  String                jsonBody = """
    "etab_id":${bar.id},
    "instructions":"",
    "waiting_time":"00:$arrivingInString",
    "payment":"${paymentMethod.toString()}",
    "tip":0,
    "items_id":$products
  """ ;

  print("JSON BODY == $jsonBody");

  Response    response = await post(url, headers: headers, body: jsonBody);
  print("RESPONSE BODY = ${response.body}");
  return response.body ;
}