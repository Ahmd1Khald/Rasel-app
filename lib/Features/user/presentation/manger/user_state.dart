part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingUploadPhotoState extends UserState {}

class UserSuccessUploadPhotoState extends UserState {}

class UserErrorUploadPhotoState extends UserState {
  final String errorMsg;
  UserErrorUploadPhotoState(this.errorMsg);
}

class UserLoadingSetProfileState extends UserState {}

class UserSuccessSetProfileState extends UserState {}

class UserErrorSetProfileState extends UserState {
  final String errorMsg;
  UserErrorSetProfileState(this.errorMsg);
}

class UserLoadingSetCoverState extends UserState {}

class UserSuccessSetCoverState extends UserState {}

class UserErrorSetCoverState extends UserState {
  final String errorMsg;
  UserErrorSetCoverState(this.errorMsg);
}

class UserLoadingFetchUserData extends UserState {}

class UserSuccessFetchUserData extends UserState {
  final UserModel userData;
  UserSuccessFetchUserData(this.userData);
}

class UserErrorFetchUserData extends UserState {
  final String errorMsg;
  UserErrorFetchUserData(this.errorMsg);
}
