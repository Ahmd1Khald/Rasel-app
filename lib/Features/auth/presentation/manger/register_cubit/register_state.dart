part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String uid;
  RegisterSuccessState(this.uid);
}

class RegisterErrorState extends RegisterState {
  final String errorMsg;
  RegisterErrorState(this.errorMsg);
}

class RegisterLoadingState extends RegisterState {}

class RegisterChangeObscureIconState extends RegisterState {}
