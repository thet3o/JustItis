import 'dart:html';

bool checkIfMobile(){
  final userAgent = window.navigator.userAgent.toString().toLowerCase();
  if(userAgent.contains('android') || userAgent.contains('iphone')){
    return true;
  }
  return false;
}

//bool checkIfMobile(context){
//  bool isMobile = MediaQuery.of(context).size.width < 850;
//  bool isTablet = MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;
//  if(isMobile || isTablet){return true;}
//  return false;
//}