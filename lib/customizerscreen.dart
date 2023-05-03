import 'package:flutter/material.dart';

class CustomizerScreen extends StatefulWidget{
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