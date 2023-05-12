import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justitis/cartsheet.dart';
import 'package:justitis/customizer.dart';
import 'package:justitis/models.dart';
import 'package:justitis/networkservice.dart';
import 'package:badges/badges.dart' as badges;

class MenuScreen extends StatefulWidget{
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen>{

  List<Item> paniniFocaccie = [];
  List<Item> addonPaniniFocaccie = [];
  List<Item> snacks = [];
  List<Item> drinks = [];
  int itemsInCart = 0;

  void getIngredients() async{
    final data = await NetworkService.getIngredients();
    setState((){
      paniniFocaccie = data.where((element) => element.tipoProdotto == 1).toList();
      snacks = data.where((element) => element.tipoProdotto == 4).toList();
      drinks = data.where((element) => element.tipoProdotto == 5).toList();
      addonPaniniFocaccie = data.where((element) => element.tipoProdotto == 2).toList();
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
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            showBadge: true,
            badgeContent: Text(itemsInCart.toString()),
            child: Center(child: IconButton(onPressed: (){
              showModalBottomSheet(
                context: context, 
                builder: (context) => const CartSheet()
              ).whenComplete(() => setState((){itemsInCart = Cart.storedCartItems.length;}));
            }, icon: const Icon(Icons.shopping_cart)),),
          )
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
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => CustomizerSheet(context: context, customizerList: addonPaniniFocaccie, baseItem: paniniFocaccie[index],)
                            ).whenComplete(() => setState((){
                              itemsInCart = Cart.storedCartItems.length;
                            }));
                          },
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
                          onTap: () {
                            Cart.addCartItem([snacks[index]]);
                            setState(() {
                              itemsInCart = Cart.storedCartItems.length;
                            });
                          },
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
                          onTap: () {
                            Cart.addCartItem([snacks[index]]);
                            setState(() {
                              itemsInCart = Cart.storedCartItems.length;
                            });
                          },
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