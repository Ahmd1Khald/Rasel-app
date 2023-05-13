import 'package:chatapp/Features/auth/presentation/views/login/login_screen.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/helpers/cachehelper.dart';
import '../../../../../core/utils/constants/variables.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginUser(
    TextEditingController emailController,
    TextEditingController passController,
  ) async {
    emit(LoginLoadingState());

    try {
      var value = await AppVariables.firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      emit(LoginSuccessState(value.user!.uid));
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          // Handle user not found error
          print('User not found');
          emit(LoginErrorState('User not found'));
        } else if (error.code == 'wrong-password') {
          // Handle wrong password error
          print('Wrong password');
          emit(LoginErrorState('Wrong password'));
        } else {
          // Handle other FirebaseAuthException errors
          print('FirebaseAuthException: ${error.code}');
          if (error.code == 'network-request-failed') {
            emit(LoginErrorState('Check your Signal!'));
          } else {
            emit(LoginErrorState(error.message!));
          }
        }
      } else {
        // Handle generic errors
        print('Error: $error');
        emit(LoginErrorState(error.toString()));
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
        final UserCredential userCredential = await AppVariables.firebaseAuth
            .signInWithCredential(authCredential);
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
      AppFunctions.pushReplacement(
          context: context, screen: const LoginScreen());

      print("user uid is => $AppKeys.userUid");
      CacheHelper.removeData(key: AppKeys.userUid);
      CacheHelper.removeData(key: AppKeys.loginDone);
      emit(LoginSuccessGoogleSignOutState());
    }).catchError((error) {
      emit(LoginErrorGoogleSignOutState(error.toString()));
    });
  }
}
