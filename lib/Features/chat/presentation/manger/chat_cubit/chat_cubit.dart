import 'package:chatapp/Features/chat/data/repos/repo.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/utils/constants/functions.dart';
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

  late var message;

  Future<void> addMessage({
    required TextEditingController messageController,
    //required ScrollController scrollController,
    required String? name,
    required String? email,
    required String? phone,
    required String? image,
  }) async {
    emit(ChatLoadingSendMessageState());
    try {
      String userUid = CacheHelper.getDate(key: AppKeys.userUid);
      message = FirebaseFirestore.instance.collection('Messages').doc(userUid);
      message.set(({
        'message': messageController.text,
        'time': AppFunctions.dateTimeFormatted('t'),
        'year': AppFunctions.dateTimeFormatted('y'),
        'createdAt': DateTime.now(),
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
      }));
      //AppFunctions.scrollToObject(scrollController);
      messageController.clear();
      emit(ChatSuccessSendMessageState());
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        // Handle network error
        emit(ChatErrorSendMessageState(e.message!));
        print('Network error occurred: ${e.message}');
      } else {
        emit(ChatErrorSendMessageState(e.message!));
        // Handle other Firebase exceptions
        print('Firebase error occurred: ${e.message}');
      }
    } catch (e) {
      emit(ChatErrorSendMessageState('Please try again'));
      // Handle other exceptions
      print('Error occurred: $e');
    }
  }
}
