import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:justitis/models.dart';

class NetworkService{

  //Get available ingredients from backend
  static Future<List<Item>> getIngredients() async{
    final response = await http.get(Uri.https('backend.justitis.it:2004','/public/ingredients'));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List<dynamic>;
      return json.map((e) => Item.fromJson(e as Map<String,dynamic>)).toList();
    }
    return [];
  }

  /*
   * "Login" user, only to verify if is already in user table or not,
   * if second option the backend add the user to db because they is already verified by Google OAuth
  */
  static Future<double> getUserWallet(String token) async{
    final response = await http.get(
      Uri.https('backend.justitis.it:2004','/public/login'),
      headers: {
        'Authorization' : 'Bearer $token',
      }
    );
    if(response.statusCode == 200) {return double.parse(response.body);}
    return 0.0;
  }

  static Future<void> createOrder(String token, String jsonCart) async{
    final response = await http.post(
      Uri.https('backend.justitis.it:2004','/public/order/create'),
      headers: {
        'Authorization' : 'Bearer $token',
      },
      body: jsonCart
    );
  }

  static Future<void> getOrderStatus(String token) async{
    // TODO get order status function that return order status
  } 

}