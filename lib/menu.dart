import 'package:flutter/material.dart';
import 'package:justitis/models.dart';
import 'package:justitis/networkservice.dart';

class MenuScreen extends StatefulWidget{
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>{

  List<Item> paniniFocaccie = [];
  List<Item> snacks = [];
  List<Item> drinks = [];

  void getIngredients() async{
    final data = await NetworkService.getIngredients();
    setState((){
      paniniFocaccie = data.where((element) => element.tipoProdotto == 1).toList();
      snacks = data.where((element) => element.tipoProdotto == 4).toList();
      drinks = data.where((element) => element.tipoProdotto == 5).toList();
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
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            color: const Color.fromARGB(229, 244, 188, 21),
            child: Column(
              children: [
                const DefaultTextStyle(
                  style: TextStyle(fontSize: 20,),
                  textAlign: TextAlign.center,
                  child: Text('Panini & Focacce'),
                  ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: paniniFocaccie.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(paniniFocaccie[index].nome!),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(255, 255, 172, 7),
            child: Column(
              children: [
                const DefaultTextStyle(
                  style: TextStyle(fontSize: 20,),
                  textAlign: TextAlign.center,
                  child: Text('Snacks'),
                  ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snacks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snacks[index].nome!),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          ),
          Container(
            height: 200,
            color: const Color.fromARGB(193, 255, 139, 7),
            child: Column(
              children: [
                const DefaultTextStyle(
                  style: TextStyle(fontSize: 20,),
                  textAlign: TextAlign.center,
                  child: Text('Drinks'),
                  ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(drinks[index].nome!),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }
}