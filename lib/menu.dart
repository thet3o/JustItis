import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justitis/models.dart';

class MenuScreen extends StatefulWidget{
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>{

  List<Item> items = [];

  Future loadAsset() async{
    String jsonString = await rootBundle.loadString('assets/ingredienti.json');
    final json = jsonDecode(jsonString) as List<dynamic>;
    setState(() {
      items = json.map((e) => Item.fromJson(e as Map<String,dynamic>)).toList();
    });
  }

  @override
  void initState() {
    loadAsset();
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
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(items[index].nome),
                  ),
                );
              },
            )
        ],
      )
    );
  }
}