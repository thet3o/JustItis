import 'package:flutter/material.dart';

class UserAlertScreen extends StatefulWidget{
  @override
  UserAlertScreenState createState() => UserAlertScreenState();
}

class UserAlertScreenState extends State<UserAlertScreen>{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: ColoredBox(
        color: Colors.red,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height/2,
                  width: size.width/2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.white, width: 10),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.warning_amber_rounded, color: Colors.amberAccent, size: 100,),
                            Text('Dispositivo attualmente non supportato'),
                            Text('In arrivo con prossimi updates', style: TextStyle(fontSize: 15),),
                          ],
                        )),
                      )
                  ),
                )
              ],
            ),
          ),
        )
      );
  }
}