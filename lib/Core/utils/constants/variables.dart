import 'package:firebase_auth/firebase_auth.dart';

class AppVariables {
  static Uri appUrl = Uri.parse('https://github.com/Ahmd1Khald');

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static late final String phoneAuthId;

  static late final String verifiedId;

  static bool userPhoneAuth = false;

  static bool isDark = false;
}
