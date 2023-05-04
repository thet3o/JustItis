import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justitis/menu.dart';
import 'package:justitis/networkservice.dart';
import 'package:justitis/oauth.dart';
import 'package:justitis/walletscreen.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  final advancedDrawerController = AdvancedDrawerController();
  double saldo = 0.0;
  String status = 'Fai il login!';

  void getWallet() async{
    final saldoDB = await NetworkService.getUserWallet(GoogleOAuth.authentication.accessToken!);
    setState(() {
      saldo = saldoDB;
    });
  }

  @override
  void initState() {
    super.initState();
    GoogleOAuth.googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async{
      GoogleOAuth.currentUser = account;
      if(GoogleOAuth.currentUser != null){
        GoogleOAuth.authentication = await GoogleOAuth.currentUser!.authentication;
        getWallet();
        setState(() {
          GoogleOAuth.isLogged = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if(GoogleOAuth.isLogged){
      status = 'Ordina!';
    }else{
      status = 'Fai il login!';
    }

    return AdvancedDrawer(
      backdropColor: const Color.fromARGB(239, 144, 71, 12),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      rtlOpening: true,
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128,
                height: 128,
                margin: const EdgeInsets.only(top: 24, bottom: 64),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                child: (GoogleOAuth.currentUser?.photoUrl != null)? Image.network(GoogleOAuth.currentUser!.photoUrl!) : const Text('Hello'),
              ),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 20, color: Colors.white70),
                child: Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 5),
                  child: GoogleOAuth.isLogged ? Text((GoogleOAuth.currentUser!.displayName!)) : const Text('Guest'),
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 15, color: Colors.white70),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: GoogleOAuth.isLogged ? Text('Wallet: € $saldo') : const Text('Wallet: € 0'),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    if (GoogleOAuth.isLogged){
                      GoogleOAuth.googleSignIn.signOut();
                      GoogleOAuth.isLogged = false;
                    }else{
                      GoogleOAuth.googleSignIn.signIn();
                    }
                    
                  });
                },
                leading: GoogleOAuth.isLogged == true ? const Icon(Icons.logout) : const Icon(Icons.login),
                title:  GoogleOAuth.isLogged ? const Text('Logout') : const Text('Login'),
              ),
              if (GoogleOAuth.isLogged)
                ListTile(
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WalletScreen())
                  );
                },
                leading: const Icon(Icons.wallet),
                title: const Text('Ricarica Wallet'),
                ),
              if (GoogleOAuth.isLogged)
                ListTile(
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuScreen())
                  );
                },
                leading: const Icon(Icons.restaurant_menu),
                title: const Text('Ordina'),
                ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 12, color: Colors.white60),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Text('Copyright by JustItis'),
                ),
              )
            ],
          ),
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('JustItis', style: TextStyle(color: Colors.white60, fontSize: 30),),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Show Drawer',
              onPressed: () => advancedDrawerController.toggleDrawer(),
            )
          ],
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/home_background.jpg'), fit: BoxFit.cover)
          ),
          child: SafeArea(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 143, 0),
                    fixedSize: const Size(200, 50)
                  ),
                  onPressed: () {
                    if(!GoogleOAuth.isLogged){
                      advancedDrawerController.showDrawer();
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MenuScreen()));
                    }
                  }, 
                  child: Text(status, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),)
                ),
              )
            ],
          ),
          )
        )
      ),
    );
  }
}