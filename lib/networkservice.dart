import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:justitis/models.dart';

class NetworkService{

  //Get available ingredients from backend
  static Future<List<Item>> getIngredients() async{
    final response = await http.get(Uri.http('5.172.80.0:2004','/public/ingredients'));
    //final response = await http.get(Uri.https('5.172.80.0:2004','/public/ingredients'));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List<dynamic>;
      return json.map((e) => Item.fromJson(e as Map<String,dynamic>)).toList();
    }
    return [];
  }

  static Future<double> getUserWallet(String token) async{
    final response = await http.get(
      Uri.http('5.172.80.0:2004','/public/login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization' : 'Bearer $token'
      }
    );
    if(response.statusCode == 200) {return double.parse(response.body);}
    return 0.0;
    //final response = await http.get(Uri.https('5.172.80.0:2004','/public/ingredients'));
  }

}