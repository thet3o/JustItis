import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:justitis/homescreen.dart';
import 'package:justitis/useralertscreen.dart';
import 'package:justitis/utils.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      theme: ThemeData(
        primaryTextTheme: Typography().black,
        textTheme: Typography().black
      ),
      color: Colors.amber[700],
      home: checkIfMobile() ? const HomeScreen() : const UserAlertScreen(),
    );
  }
}
