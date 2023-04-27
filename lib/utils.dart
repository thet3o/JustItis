import 'dart:html';

bool checkIfMobile(){
  final userAgent = window.navigator.userAgent.toString().toLowerCase();
  if(userAgent.contains('android') || userAgent.contains('iphone')){
    return true;
  }
  return false;
}