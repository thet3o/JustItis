import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:justitis/models.dart';

class CartSheet extends StatefulWidget{
  const CartSheet({super.key});

  @override
  CartSheetState createState() => CartSheetState();
}

class CartSheetState extends State<CartSheet>{
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
                  ),
                )
              );
            },
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
}