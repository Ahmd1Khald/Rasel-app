import 'package:chatapp/Features/chat/data/models/user_model.dart';
import 'package:chatapp/Features/chat/data/repos/repo_implement.dart';
import 'package:chatapp/Features/chat/presentation/manger/chat_cubit/chat_cubit.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/colors.dart';
import 'chat_widgets/chat_appbar.dart';
import 'chat_widgets/chat_textformfield.dart';
import 'mydrawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var scrollController = ScrollController();
    UserModel? result;
    CollectionReference message =
        FirebaseFirestore.instance.collection('Messages');
    return BlocProvider(
      create: (context) =>
          ChatCubit(ChatRepoImplement())..fetchUserData(uid: uid),
      child: BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
        //Loading
        if (state is ChatLoadingFetchUserData) {
          AppFunctions.loadingPage(context: context);
        } else if (state is ChatLoadingSendMessageState) {
          AppFunctions.loadingPage(context: context);
        }
        //Error
        else if (state is ChatErrorFetchUserData) {
          myToast(state: state.errorMsg, toastState: ToastState.error);
          print(state.errorMsg);
          //Navigator.pop(context);
        } else if (state is ChatErrorSendMessageState) {
          myToast(state: state.errMessage, toastState: ToastState.error);
          Navigator.pop(context);
        }
        //Success
        else if (state is ChatSuccessFetchUserData) {
          result = state.userData;
          print(result);
          myToast(state: 'Fetched success!', toastState: ToastState.success);
          print('--------------');
          print(result);
          print('--------------');
          //Navigator.pop(context);
        } else if (state is ChatSuccessSendMessageState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.chatBackGroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.lightDark,
            centerTitle: true,
            actions: const [ChatAppBar()],
          ),
          drawer: MyDrawer(
            userdata: result,
          ),
          body: Column(
            children: [
              const Spacer(),
              ChatTextFormField(
                onPressed: () {
                  ChatCubit.get(context).addMessage(
                    messageController: messageController,
                    name: result?.name,
                    phone: result?.phone,
                    image: result?.image,
                    email: result?.email,
                  );
                },
                messageController: messageController,
              ),
            ],
          ),
        );
      }),
    );
  }
}
