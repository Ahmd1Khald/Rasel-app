import 'package:bloc/bloc.dart';
import 'package:chatapp/Features/auth/presentation/views/login/login_screen.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/helpers/cachehelper.dart';
import '../../../../../core/helpers/firebase_services.dart';
import '../../../../../core/utils/constants/variables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginUser(
    TextEditingController emailController,
    TextEditingController passController,
  ) async {
    emit(LoadingLoginState());

    try {
      var value = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      AppVariables.userEmail = emailController.text;
      emit(SuccessLoginState(value.user!.uid));
    }catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          // Handle user not found error
          print('User not found');
          emit(ErrorLoginState('User not found'));
        } else if (error.code == 'wrong-password') {
          // Handle wrong password error
          print('Wrong password');
          emit(ErrorLoginState('Wrong password'));
        } else {
          // Handle other FirebaseAuthException errors
          print('FirebaseAuthException: ${error.code}');
          if(error.code == 'network-request-failed')
            {
              emit(ErrorLoginState('Check your Signal!'));
            }else{
            emit(ErrorLoginState(error.message!));
          }
        }
      } else {
        // Handle generic errors
        print('Error: $error');
        emit(ErrorLoginState(error.toString()));
      }
    }
  }

  bool isShowPassIcon = true;
  IconData passIcon = Icons.visibility_off;

  void loginChangePassIcon({
    required bool isShow,
  }) {
    if (isShow) {
      passIcon = Icons.visibility_off;
    } else {
      passIcon = Icons.visibility;
    }
    emit(LoginChangeObscureIconState());
    isShowPassIcon = !isShow;
  }

  //final FirebaseServices firebaseServices = FirebaseServices();
  final GoogleSignIn gSignIn = GoogleSignIn();

  Future<void> googleSignIn() async {
    emit(LoginLoadingGoogleSignInState());
    try {
      // await firebaseServices.googleSignIn().then((value) {
      //   emit(LoginSuccessGoogleSignInState(value!.uid));
      //   print("------------------${value.uid}");
      // });
      // Create a new instance of GoogleSignIn

      // Start the Google Sign-In process
      final GoogleSignInAccount? account = await gSignIn.signIn();

      if (account != null) {
        // Retrieve the authentication token
        final GoogleSignInAuthentication authentication =
        await account.authentication;

        // Use the token to sign in to your Firebase backend
        // For example:
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(authCredential);
        final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);
        emit(LoginSuccessGoogleSignInState(userCredential.user!.uid));

        // If sign-in is successful, proceed with the rest of your logic
        // ...
      } else {
        // User canceled the sign-in process
        print('Google Sign-In canceled by user');
        emit(LoginErrorGoogleSignInState('Google Sign-In canceled'));
      }



    } on PlatformException catch (error) {
      if (error.code == 'sign_in_failed') {
        // Handle specific sign-in failure
        print('Google Sign-In Failed');
        print(error.message.toString());
        emit(LoginErrorGoogleSignInState(error.message.toString()));
      } else {
        // Handle other platform exceptions
        print('Error: ${error.message}');
        emit(LoginErrorGoogleSignInState(error.message.toString()));
      }
    } catch (error) {
      // Handle any other exceptions
      print('Error: $error');
      emit(LoginErrorGoogleSignInState(error.toString()));
    }

    // try {
    //   await firebaseServices.googleSignIn().then((value) {
    //     emit(LoginSuccessGoogleSignInState(value!.uid));
    //     print("------------------${value.uid}");
    //   });
    //
    // } on FirebaseAuthException catch (error) {
    //   emit(LoginErrorGoogleSignInState(error.message.toString()));
    //   print(error.message.toString());
    // }
  }

  Future<void> googleSignOut(context) async {
    emit(LoginLoadingGoogleSignOutState());
    await gSignIn.signOut().then((value) {
      AppFunctions.pushReplacement(context: context, screen: const LoginScreen());

      print("user uid is => $AppKeys.userUid");
      CacheHelper.removeData(key: AppKeys.userUid);
      CacheHelper.removeData(key: AppKeys.loginDone);
      emit(LoginSuccessGoogleSignOutState());
    }).catchError((error){
      emit(LoginErrorGoogleSignOutState(error.toString()));
    });
  }

  void phoneAuth({required String num}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: num,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User user = userCredential.user!;

        emit(LoginSuccessPhoneAuthState(user.uid));
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(LoginErrorPhoneAuthState(e.message!));
        print('Error phone auth${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        AppVariables.verification = verificationId;

        ///todo code send
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        AppVariables.verification = verificationId;
      },
    );
  }
}
