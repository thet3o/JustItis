import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:justitis/models.dart';

void retrieveIngredients() async {
  final response = await http.get(Uri.parse('http://5.172.80.0:2004/public/ingredients'));
  List<Item> items = [];
  print(response.statusCode);
  if (response.statusCode == 200) {
    //// JSON to Ingredients List 
    //final json = jsonDecode(response.body) as List<dynamic>;
    //items = json.map((e) => Item.fromJson(e as Map<String,dynamic>)).toList();
    print(response.body);
  }
}

void main() {
  retrieveIngredients();
}