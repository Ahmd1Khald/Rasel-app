part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoadingFetchUserData extends ChatState {}

class ChatSuccessFetchUserData extends ChatState {
  final UserModel userData;
  ChatSuccessFetchUserData(this.userData);
}

class ChatErrorFetchUserData extends ChatState {
  final String errorMsg;
  ChatErrorFetchUserData(this.errorMsg);
}
