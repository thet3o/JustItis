import 'package:flutter/material.dart';
import 'package:justitis/models.dart';

class CustomizerSheet extends StatefulWidget{
  const CustomizerSheet({
    super.key,
    required this.context,
    required this.customizerList,
    required this.baseItem,
  });

  final List<Item> customizerList;
  final Item baseItem;
  final BuildContext context;

  @override
  CustomizerSheetState createState() => CustomizerSheetState();
}

class CustomizerSheetState extends State<CustomizerSheet>{

  @override
  void initState() {
    for(int i = 0; i < widget.customizerList.length; i++){
      widget.customizerList[i].selected = false;
    }
    super.initState();
  }

  @override
  Widget build(Object context) {
    List<Item> customizations = List.from(widget.customizerList);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          child: Text('Customizer ${widget.baseItem.nome}'),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: customizations.length,
            itemBuilder: (context, index) {
              return Card(
                child: CheckboxListTile(
                  title: Text(customizations[index].nome!),
                  subtitle: Text('€${customizations[index].prezzo!.toString()}'),
                  value: customizations[index].selected,
                  onChanged: (value) {
                    setState(() {
                      customizations[index].selected = value!;
                    });
                  },
                ),
              );
            },
          ),
        ),
        IconButton(onPressed: () {
          final items = customizations.where((element) => element.selected).toList();
          items.insert(0, widget.baseItem);
          Cart.addCartItem(items);
          Navigator.of(widget.context).pop();
        }, icon: const Icon(Icons.add_shopping_cart))
      ],
    );
  }
}