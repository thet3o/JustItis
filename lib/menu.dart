import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justitis/models.dart';
import 'package:http/http.dart' as http;
import 'package:justitis/networkservice.dart';

class MenuScreen extends StatefulWidget{
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>{

  List<Item> items = [];

  void getIngredients() async{
    final data = await NetworkService.getIngredients();
    setState((){
      items = data;
    });
  }
  
  @override
  void initState(){
    getIngredients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordina'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.pop(context);
        },),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(items[index].nome!),
                  ),
                );
              },
            )
        ],
      )
    );
  }
}