import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      emit(ErrorLoginState(error.message!));
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

  final FirebaseServices _authentication = FirebaseServices();

  void googleSignIn() async {
    emit(LoginLoadingGoogleSignInState());
    try {
      var value = await _authentication.googleSignIn();
      emit(LoginSuccessGoogleSignInState(value!.uid));
      print("------------------${value.uid}");
    } on FirebaseAuthException catch (error) {
      emit(LoginErrorGoogleSignInState(error.message.toString()));
      print(error.message.toString());
    }
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
