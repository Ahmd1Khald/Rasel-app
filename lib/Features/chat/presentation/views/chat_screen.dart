import 'package:chatapp/Features/chat/data/repos/repo_implement.dart';
import 'package:chatapp/Features/chat/presentation/manger/chat_cubit/chat_cubit.dart';
import 'package:chatapp/core/utils/constants/assets_images.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/constants/colors.dart';
import 'mydrawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var scrollController = ScrollController();
    var result;
    CollectionReference message =
        FirebaseFirestore.instance.collection('Messages');
    return BlocProvider(
      create: (context) =>
          ChatCubit(ChatRepoImplement())..fetchUserData(uid: uid),
      child: BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
        if (state is ChatLoadingFetchUserData) {
          AppFunctions.loadingPage(context: context);
        } else if (state is ChatErrorFetchUserData) {
          myToast(state: state.errorMsg, toastState: ToastState.error);
          print(state.errorMsg);
          //Navigator.pop(context);
        } else if (state is ChatSuccessFetchUserData) {
          result = state.userData;
          myToast(state: 'Fetched success!', toastState: ToastState.success);
          print(state.userData);
          print('--------------');
          //Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            // centerTitle: true,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitSpinningCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                            //color: index.isEven ? Colors.white : Colors.white.withOpacity(0.5),
                            image: DecorationImage(
                          image: AssetImage(AppAssetsImages.logo2Image),
                        )),
                      );
                    },
                    duration: const Duration(milliseconds: 2500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Chatty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )
                ],
              ),
              /*SizedBox(
                width: 100.w,
              ),*/
            ],
          ),
          drawer: const MyDrawer(),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/chat_dark_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: AppStyles.title3,
                      autofocus: true,
                      cursorHeight: 25.h,
                      cursorColor: AppColors.midGrey,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            // AppCubit.get(context).addMessage(
                            //   image: CacheHelper.getDate(key: 'photoURL'),
                            //   email: AppVariables.userEmail,
                            //   messageController: messageController,
                            //   scrollController: scrollController,
                            // );
                          },
                          icon: Icon(
                            Icons.send,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        hintText: 'Message',
                        hintStyle: AppStyles.hintText,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                      ),
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email is too small';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        /*StreamBuilder<QuerySnapshot>(
          stream: message.orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: HexColor('#dedede'),
                appBar: AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  // centerTitle: true,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitSpinningCircle(
                          itemBuilder: (BuildContext context, int index) {
                            return const DecoratedBox(
                              decoration: BoxDecoration(
                                  //color: index.isEven ? Colors.white : Colors.white.withOpacity(0.5),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/logo.png'))),
                            );
                          },
                          duration: const Duration(milliseconds: 2500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Chat App',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                  ],
                ),
                drawer: const MyDrawer(),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        shrinkWrap: true,
                        //physics: const FixedExtentScrollPhysics(),
                        itemBuilder: (context, index) =>
                            snapshot.data!.docs[index]['userEmail'],
                        */ /*? builtMyMessage(
                              backgroundColor: AppColors.messageColor!,
                              msg: snapshot.data!.docs[index]['text'],
                              time: snapshot.data!.docs[index]['time'],
                              year: snapshot.data!.docs[index]['year'],
                              image: snapshot.data!.docs[index]['image'],
                            )
                                : builtFriendsMessage(
                              image: snapshot.data!.docs[index]['image'],
                              backgroundColor: Colors.grey,
                              msg: snapshot.data!.docs[index]['text'],
                              time: snapshot.data!.docs[index]['time'],
                              year: snapshot.data!.docs[index]['year'],
                            ),
*/ /*
                        itemCount: snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.length
                            : 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: AppColors.backgroundColor,
                            cursorHeight: 30,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    // if (messageController.text.isNotEmpty) {
                                    //   AppCubit.get(context).addMessage(
                                    //       email: AppVariables.userEmail,
                                    //       messageController:
                                    //       messageController,
                                    //       scrollController: scrollController,
                                    //       image: CacheHelper.getDate(
                                    //           key: 'photoURL'));
                                    // }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: AppColors.backgroundColor,
                                  )),
                              hintText: 'Message',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.backgroundColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.backgroundColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.backgroundColor)),
                            ),
                            controller: messageController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email is too small';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundColor,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/chat.png',
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Chat App',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: AppColors.backgroundColor,
                      cursorHeight: 30,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              // AppCubit.get(context).addMessage(
                              //   image: CacheHelper.getDate(key: 'photoURL'),
                              //   email: AppVariables.userEmail,
                              //   messageController: messageController,
                              //   scrollController: scrollController,
                              // );
                            },
                            icon: Icon(
                              Icons.send,
                              color: AppColors.backgroundColor,
                            )),
                        hintText: 'Message',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.backgroundColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.backgroundColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.backgroundColor)),
                      ),
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email is too small';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );*/
      }),
    );
  }
}
