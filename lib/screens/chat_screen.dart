import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import '../core/utils/constants/colors.dart';
import '../core/widgets/components.dart';
import 'mydrawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var scrollController = ScrollController();
    CollectionReference message =
        FirebaseFirestore.instance.collection('Messages');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: message.orderBy('createdAt', descending: true).snapshots(),
            builder: (context, snapshot) {
              print(CacheHelper.getDate(key: 'AppVariables.userEmail'));
              print(CacheHelper.getDate(key: 'userName'));
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
                          itemBuilder: (context, index) => snapshot
                                      .data!.docs[index]['userEmail'] ==
                                  AppVariables.userEmail
                              ? builtMyMessage(
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
                                      if (messageController.text.isNotEmpty) {
                                        AppCubit.get(context).addMessage(
                                            email: AppVariables.userEmail,
                                            messageController:
                                                messageController,
                                            scrollController: scrollController,
                                            image: CacheHelper.getDate(
                                                key: 'photoURL'));
                                      }
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: AppColors.backgroundColor,
                                    )),
                                hintText: 'Message',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.backgroundColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.backgroundColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.backgroundColor)),
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
                                AppCubit.get(context).addMessage(
                                  image: CacheHelper.getDate(key: 'photoURL'),
                                  email: AppVariables.userEmail,
                                  messageController: messageController,
                                  scrollController: scrollController,
                                );
                              },
                              icon: Icon(
                                Icons.send,
                                color: AppColors.backgroundColor,
                              )),
                          hintText: 'Message',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.backgroundColor)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.backgroundColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.backgroundColor)),
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
          );
        });
  }
}
