part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginChangeObscureIconState extends LoginState {}

class LoginLoadingGoogleSignInState extends LoginState {}

class LoginErrorGoogleSignInState extends LoginState {
  final String errorMsg;
  LoginErrorGoogleSignInState(this.errorMsg);
}

class LoginSuccessGoogleSignInState extends LoginState {
  final String uid;
  LoginSuccessGoogleSignInState(this.uid);
}

class LoginLoadingGoogleSignOutState extends LoginState {}

class LoginErrorGoogleSignOutState extends LoginState {
  final String errorMsg;
  LoginErrorGoogleSignOutState(this.errorMsg);
}

class LoginSuccessGoogleSignOutState extends LoginState {}


class SuccessLoginState extends LoginState {
  final String uid;
  SuccessLoginState(this.uid);
}

class ErrorLoginState extends LoginState {
  final String errorMsg;
  ErrorLoginState(this.errorMsg);
}

class LoadingLoginState extends LoginState {}

class LoginSuccessPhoneAuthState extends LoginState {
  final String uid;
  LoginSuccessPhoneAuthState(this.uid);
}

class LoginErrorPhoneAuthState extends LoginState {
  final String errorMsg;
  LoginErrorPhoneAuthState(this.errorMsg);
}

class LoginLoadingPhoneAuthState extends LoginState {}
