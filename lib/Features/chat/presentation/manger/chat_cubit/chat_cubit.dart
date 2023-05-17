import 'package:chatapp/Features/chat/data/repos/repo.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRepo chatRepo;

  Future<void> fetchUserData({required String uid}) async {
    emit(ChatLoadingFetchUserData());
    var result = await chatRepo.fetchUserData(uid: uid);

    result.fold((failer) {
      emit(ChatErrorFetchUserData(failer.errMessage));
    }, (userData) {
      emit(ChatSuccessFetchUserData(userData));
    });
  }

  final GoogleSignIn gSignIn = GoogleSignIn();

  void logout() async {
    emit(ChatLoadingLogoutState());
    try {
      await gSignIn.signOut();
      CacheHelper.removeData(key: AppKeys.userUid);
      CacheHelper.removeData(key: AppKeys.loginDone);
      AppVariables.userPhoneAuth = false;
      emit(ChatSuccessLogoutState());
    } catch (error) {
      emit(ChatErrorLogoutState(error.toString()));
    }
  }
}
