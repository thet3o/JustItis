import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:justitis/models.dart';
import 'package:justitis/networkservice.dart';
import 'package:justitis/oauth.dart';
import 'package:intl/intl.dart';

class CartSheet extends StatefulWidget{
  const CartSheet({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  CartSheetState createState() => CartSheetState();
}

class CartSheetState extends State<CartSheet>{

  final currency = NumberFormat('##0.0#', 'it_IT');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DefaultTextStyle(
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          child: Text('Cart'),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Cart.storedCartItems.length,
            itemBuilder: (context, index) {
              return Card(
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        onPressed: (context){setState(() {
                          Cart.removeCartItem(index);
                        });},
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(Cart.storedCartItems[index].group[0].item.nome!),
                    subtitle: Text(subtitleGenerator(Cart.storedCartItems[index].group)),
                    trailing: Text('€${currency.format(totalItemCost(Cart.storedCartItems[index].group))}'),
                  ),
                )
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
            ),
            onPressed: ()async{
              if (Cart.storedCartItems.isNotEmpty){
                if(await NetworkService.createOrder(GoogleOAuth.authentication.accessToken!)){
                  if(context.mounted) Navigator.of(widget.context).pop();
                }
              }
            }, 
            child: DefaultTextStyle(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
              child: (Cart.storedCartItems.isNotEmpty) ? const Text('Ordina') : const Text('Cart Vuoto'),
            )
          ),
        )
      ],
    );
  }

  String subtitleGenerator(List<CartItemGroupElement> list){
    String sub = '';
    for(int i = 1; i < list.length; i++){
      sub += '${list[i].item.nome!} ';
    }
    return sub;
  }

  double totalItemCost(List<CartItemGroupElement> list){
    double totalCost = 0.0;
    for(int i = 0; i < list.length; i++){
      totalCost += list[i].item.prezzo!;
    }
    return totalCost;
  }
}