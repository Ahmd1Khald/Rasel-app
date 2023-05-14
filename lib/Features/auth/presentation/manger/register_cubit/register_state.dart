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

class RegisterLoadingUploadPhotoState extends RegisterState {}

class RegisterSuccessUploadPhotoState extends RegisterState {}

class RegisterErrorUploadPhotoState extends RegisterState {
  final String errorMsg;

  RegisterErrorUploadPhotoState(this.errorMsg);
}

class RegisterErrorSetPhotoState extends RegisterState {
  final String errorMsg;

  RegisterErrorSetPhotoState(this.errorMsg);
}
