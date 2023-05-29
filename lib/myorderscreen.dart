import 'package:flutter/material.dart';
import 'package:justitis/models.dart';
import 'package:justitis/networkservice.dart';
import 'package:justitis/oauth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  @override
  void initState() {
    super.initState();
    getUserOrders();
  }

  List<String> getInfosFromIngredients(List<dynamic> subingredients){

    for (var element in paniniFocaccie) {
      String title = '';
      List<String> addonsList = []; 
      if(subingredients.contains(element.id)){
        title = element.nome!;
        for(var addon in addonPaniniFocaccie){
          if(subingredients.contains(addon.id)){
            addonsList.add(addon.nome!);
          }
        }
        return [title, addonsList.toString().replaceAll('[', '').replaceAll(']', '')];
      }
    }
    for (var element in snacks) { 
      if(subingredients.contains(element.id)){
        return [element.nome!];
      }
    }
    for (var element in drinks) { 
      if(subingredients.contains(element.id)){
        return [element.nome!];
      }
    }
    return [];
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
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    title: Text('Ordine ${orders.length-i}'),
                    subtitle: Text('Spesa totale: €${orders[i].costoOrdine}'),
                    trailing: Text(orders[i].orderStatus!),
                    onTap: () {
                      showModalBottomSheet(context: context, builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                              child: Text('Dettagli Ordine ${orders.length-i}'),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: orders[i].ingredients.length,
                                itemBuilder: (context, x) {
                                  final List<String> infos = getInfosFromIngredients(orders[i].ingredients[x]);
                                  return Card(
                                    child: ListTile(
                                      title: Text(infos[0]),
                                      subtitle: (infos.length == 2)? Text(infos[1]) : null,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }, showDragHandle: true, enableDrag: true);
                    },
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