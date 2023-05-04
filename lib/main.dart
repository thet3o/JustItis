import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:justitis/homescreen.dart';
import 'package:justitis/useralertscreen.dart';
import 'package:justitis/utils.dart';
import 'package:pwa_install/pwa_install.dart';
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  PWAInstall().setup(installCallback: () {});
  if(PWAInstall().installPromptEnabled){
    PWAInstall().promptInstall_();
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      //home: HomeScreen()
      home: checkIfMobile() ? HomeScreen() : UserAlertScreen(),
    );
  }
}
