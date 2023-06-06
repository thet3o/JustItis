import 'package:flutter/material.dart';
import 'package:justitis/models.dart';

class CustomizerSheet extends StatefulWidget{
  const CustomizerSheet(
  {
    super.key,
    required this.context,
    required this.customizerList,
    required this.baseItem,
    required this.oneSelect,
    required this.order,
  });

  final List<Item> customizerList;
  final Item baseItem;
  final BuildContext context;
  final bool oneSelect;
  final List<Item> order;

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

  Item? selectedAddon;

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
                child: (widget.oneSelect)? SingleSelectionTile(customizations, index) : MultipleSelectionTile(customizations, index),
              );
            },
          ),
        ),
        IconButton(onPressed: () {
          //final items = customizations.where((element) => element.selected).toList();
          if(widget.oneSelect){
            widget.order.add(selectedAddon!);
          }else{
            final items = customizations.where((element) => element.selected).toList();
            widget.order.addAll(items);
          }
          Navigator.of(widget.context).pop();
        }, icon: const Icon(Icons.add_shopping_cart))
      ],
    );
  }

  Widget SingleSelectionTile(List<Item> customizations, int index){
    return RadioListTile(
      value: customizations[index],
      title: Text(customizations[index].nome!),
      subtitle: Text('€${customizations[index].prezzo!.toString()}'),
      selected: selectedAddon == customizations[index],
      onChanged: (value) {
        setState(() {
          selectedAddon = value;
        });
      }, groupValue: selectedAddon,
    );
  }

  Widget MultipleSelectionTile(List<Item> customizations, int index){
    return CheckboxListTile(
      title: Text(customizations[index].nome!),
      subtitle: Text('€${customizations[index].prezzo!.toString()}'),
      value: customizations[index].selected,
      onChanged: (value) {
        setState(() {
          customizations[index].selected = value!;
        });
      },
    );
  }

}