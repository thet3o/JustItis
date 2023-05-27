import 'package:flutter/material.dart';
import 'package:justitis/models.dart';
import 'package:justitis/networkservice.dart';
import 'package:justitis/oauth.dart';

class MyOrderScreen extends StatefulWidget{
  const MyOrderScreen({super.key});

  @override
  MyOrderScreenState createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<MyOrderScreen>{

  List<Item> paniniFocaccie = [];
  List<Item> addonPaniniFocaccie = [];
  List<Item> snacks = [];
  List<Item> drinks = [];
  List<Order> orders = [];

  void getUserOrders() async{
    final ordersData = await NetworkService.getUserOrders(GoogleOAuth.authentication.accessToken!);
    final ingredientsData = await NetworkService.getIngredients();
    setState(() {
      orders = ordersData;
      paniniFocaccie = ingredientsData.where((element) => element.tipoProdotto == 1).toList();
      snacks = ingredientsData.where((element) => element.tipoProdotto == 4).toList();
      drinks = ingredientsData.where((element) => element.tipoProdotto == 5).toList();
      addonPaniniFocaccie = ingredientsData.where((element) => element.tipoProdotto == 2).toList();
    });
  }

  List<dynamic> getOrderTitle(Order order){
    String title = '';
    for(int i = 0; i< paniniFocaccie.length; i++){
      if(order.ingredients.contains(paniniFocaccie[i].id)){
        title = paniniFocaccie[i].nome!;
        order.ingredients.remove(paniniFocaccie[i].id);
        return [title, true];
      }
    }
    for(int i = 0; i< drinks.length; i++){
      if(order.ingredients.contains(drinks[i].id)){
        title = drinks[i].nome!;
        order.ingredients.remove(drinks[i].id);
        return [title, false];
      }
    }
    for(int i = 0; i< snacks.length; i++){
      if(order.ingredients.contains(snacks[i].id)){
        title = snacks[i].nome!;
        order.ingredients.remove(snacks[i].id);
        return [title, false];
      }
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I tuoi ordini', style: TextStyle(color: Colors.black, fontSize: 30),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: () {
          Navigator.pop(context);
        },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final data = getOrderTitle(orders[index]);
                return Card(
                  child: ListTile(
                    title: Text(data[0]),
                    subtitle: (data[1])? const Text('other ingredients'): null,
                    trailing: Text(orders[index].orderStatus!),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}