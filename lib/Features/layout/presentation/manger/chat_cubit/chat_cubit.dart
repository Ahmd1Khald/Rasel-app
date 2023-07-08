import 'package:RASEL/core/helpers/cachehelper.dart';
import 'package:RASEL/core/utils/constants/keys.dart';
import 'package:RASEL/core/utils/constants/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/functions.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  late var message;

  List<String> messages = [];

  Future<void> addMessage({
    required TextEditingController messageController,
    required ScrollController scrollController,
    required String? name,
    required String? email,
    required String? phone,
    required String? image,
  }) async {
    emit(ChatLoadingSendMessageState());
    try {
      String userUid = CacheHelper.getDate(key: AppKeys.userUid);
      messages.add(messageController.text);
      message = FirebaseFirestore.instance
          .collection(AppStrings.messagesCollection)
          .doc(userUid);
      message.set(({
        'messages': messages,
        'time': AppFunctions.dateTimeFormatted('t'),
        'year': AppFunctions.dateTimeFormatted('y'),
        'createdAt': DateTime.now(),
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
      }));
      AppFunctions.scrollToObject(scrollController);
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
