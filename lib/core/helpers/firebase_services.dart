import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookLogin _facebookLogin = FacebookLogin();

  late final String email , password , name , phone;

  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    print(googleSignInAccount);

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);

    final User? user = userCredential.user;

    assert(user!.displayName != null);
    assert(user!.email != null);

    final User? currentUser = _firebaseAuth.currentUser;
    assert(currentUser!.uid == user!.uid);

    return userCredential.user;
  }

  void facebookSignIn() async {
    FacebookLoginResult result = await _facebookLogin.logIn(customPermissions: ['email']);

    final accessToken = result.accessToken!.token;

    if(result.status == FacebookLoginStatus.success){
      final facebookCredential = FacebookAuthProvider.credential(accessToken);

      await _firebaseAuth.signInWithCredential(facebookCredential);
    }
  }

  void signInWithEmailAndPassword() async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createAccountWithEmailAndPassword() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password,);

    } catch (e) {
      print(e.toString());
    }
  }

}
