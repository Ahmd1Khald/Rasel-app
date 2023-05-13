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

class LoginSuccessState extends LoginState {
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginState {
  final String errorMsg;
  LoginErrorState(this.errorMsg);
}

class LoginLoadingState extends LoginState {}
