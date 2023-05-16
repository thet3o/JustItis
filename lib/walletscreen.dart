import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget{
  const WalletScreen({super.key});

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{
  final currency = NumberFormat('##0.0#', 'it_IT');
  double saldo = 0.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Ricarica Wallet'), 
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).pop();
        },)),
      body: ColoredBox(
        color: const Color.fromARGB(122, 255, 168, 47),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 40, color: Colors.black54),
              child: Text('Saldo: € ${currency.format(saldo)}'),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionChip(label: const Text('€0.10'), onPressed: (){
                  setState(() {
                    saldo += 0.1;
                  });
                },),
                ActionChip(label: const Text('€0.20'), onPressed: (){
                  setState(() {
                    saldo += 0.2;
                  });
                },),
                ActionChip(label: const Text('€0.50'), onPressed: (){
                  setState(() {
                    saldo += 0.5;
                  });
                },)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionChip(label: const Text('€1.00'), onPressed: (){
                  setState(() {
                    saldo += 1;
                  });
                },),
                ActionChip(label: const Text('€2.00'), onPressed: (){
                  setState(() {
                    saldo += 2;
                  });
                },),
                ActionChip(label: const Text('€5.00'), onPressed: (){
                  setState(() {
                    saldo += 5;
                  });
                },)
              ],
            ),
            BarcodeWidget(
              data: '$saldo', 
              barcode: Barcode.qrCode(),
              width: 100.0,
              height: 100.0,
              margin: const EdgeInsets.all(20),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color.fromARGB(255, 249, 159, 42)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text('Annulla', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 249, 159, 42)))),
            ),
          ],
        ),
      ),
      )
    );
  }
}