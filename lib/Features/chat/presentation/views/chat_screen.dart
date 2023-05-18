import 'package:chatapp/Features/chat/data/models/user_model.dart';
import 'package:chatapp/Features/chat/data/repos/repo_implement.dart';
import 'package:chatapp/Features/chat/presentation/manger/chat_cubit/chat_cubit.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/constants/styles.dart';
import 'chat_widgets/chat_appbar.dart';
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
        FirebaseFirestore.instance.collection(AppStrings.messagesCollection);
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
          //myToast(state: 'Fetched success!', toastState: ToastState.success);
          print('--------------');
          print(result);
          print('--------------');
          //Navigator.pop(context);
        } else if (state is ChatSuccessSendMessageState) {
          print(messageController.text);
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
              Spacer(),
              /*Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) => BuiltMyMessage(
                          backgroundColor: AppColors.green,
                          image: snapshot.data?.docs[index]['image'],
                          msg: snapshot.data?.docs[index]['message'],
                          name: snapshot.data?.docs[index]['name'],
                          time: snapshot.data?.docs[index]['time'],
                          year: snapshot.data?.docs[index]['year'],
                          phone: '',
                        ),
                        reverse: true,
                        controller: scrollController,
                        itemCount: snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.length
                            : 0,
                      )),*/
              Padding(
                padding: EdgeInsets.only(top: 10.0.sp),
                child: TextFormField(
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                  style: AppStyles.title3,
                  //autofocus: true,
                  cursorHeight: 25.h,
                  cursorColor: AppColors.midGrey,
                  decoration: InputDecoration(
                    fillColor: AppColors.lightDark,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        ChatCubit.get(context).addMessage(
                          messageController: messageController,
                          name: result?.name,
                          email: result?.email,
                          phone: result?.phone,
                          image: result?.image,
                        );
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    hintText: 'Message',
                    hintStyle: AppStyles.hintText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightDark!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightDark!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightDark!),
                    ),
                  ),
                  controller: messageController,
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
