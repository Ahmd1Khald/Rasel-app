import '../../../data/models/user_model.dart';

abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class LayoutLoadingFetchUserData extends LayoutState {}

class LayoutSuccessFetchUserData extends LayoutState {
  final UserModel userData;
  LayoutSuccessFetchUserData(this.userData);
}

class LayoutErrorFetchUserData extends LayoutState {
  final String errorMsg;
  LayoutErrorFetchUserData(this.errorMsg);
}

class LayoutLoadingLogoutState extends LayoutState {}

class LayoutSuccessLogoutState extends LayoutState {}

class LayoutBottomChangedState extends LayoutState {}

class LayoutAddPostsState extends LayoutState {}

class ChangeThemeState extends LayoutState {}

class LayoutErrorLogoutState extends LayoutState {
  final String errMessage;
  LayoutErrorLogoutState(this.errMessage);
}
