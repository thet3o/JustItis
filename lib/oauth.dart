import 'package:google_sign_in/google_sign_in.dart';

class GoogleOAuth{
  static final googleSignIn = GoogleSignIn(
    clientId: '218796606716-j8ocieekuju6cp77dm7ona0l7captkgf.apps.googleusercontent.com',
    scopes: ['email', 'profile', 'openid']
  );

  static GoogleSignInAccount? currentUser;
  static late GoogleSignInAuthentication authentication;
  static bool isLogged = false;

}