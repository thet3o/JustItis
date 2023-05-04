import 'package:flutter/material.dart';
import 'package:justitis/models.dart';

class CustomizerScreen extends StatefulWidget{
  const CustomizerScreen({
    super.key,
    required this.customizerList,
  });

  final List<Item> customizerList;

  @override
  CustomizerScreenState createState() => CustomizerScreenState();
}

class CustomizerScreenState extends State<CustomizerScreen>{
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customizer'),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      ),
    );
  }
}