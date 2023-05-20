import 'package:google_sign_in/google_sign_in.dart';

class GoogleOAuth{
  static final googleSignIn = GoogleSignIn(
    clientId: '218796606716-j8ocieekuju6cp77dm7ona0l7captkgf.apps.googleusercontent.com',
    scopes: ['email', 'profile', 'openid']
  );

  static void loginSilent() async{
    await googleSignIn.signInSilently(suppressErrors: false);
  }

  static void login(){
    googleSignIn.signIn();
  }

  static GoogleSignInAccount? currentUser;
  static late GoogleSignInAuthentication authentication;
  static bool isLogged = false;
}