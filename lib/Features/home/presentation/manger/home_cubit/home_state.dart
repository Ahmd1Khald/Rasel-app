import '../../../data/models/user_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingFetchUserData extends HomeState {}

class HomeSuccessFetchUserData extends HomeState {
  final UserModel userData;
  HomeSuccessFetchUserData(this.userData);
}

class HomeErrorFetchUserData extends HomeState {
  final String errorMsg;
  HomeErrorFetchUserData(this.errorMsg);
}

class HomeLoadingLogoutState extends HomeState {}

class HomeSuccessLogoutState extends HomeState {}

class HomeBottomChangedState extends HomeState {}

class HomeErrorLogoutState extends HomeState {
  final String errMessage;
  HomeErrorLogoutState(this.errMessage);
}
