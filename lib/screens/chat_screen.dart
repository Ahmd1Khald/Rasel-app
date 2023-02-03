import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/local/cachehelper.dart';
import 'package:chatapp/shared/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/components.dart';
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
              print(CacheHelper.getDate(key: 'userEmail'));
              print(CacheHelper.getDate(key: 'userName'));
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: mainColor,
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/chat.png',
                          width: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Chat App',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  drawer: MyDrawer(),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          shrinkWrap: true,
                          //physics: const FixedExtentScrollPhysics(),
                          itemBuilder: (context, index) =>
                              snapshot.data!.docs[index]['userEmail'] ==
                                      userEmail
                                  ? builtMyMessage(
                                      backgroundColor: mainColor!,
                                      msg: snapshot.data!.docs[index]['text'],
                                      time: snapshot.data!.docs[index]['time'],
                                      year: snapshot.data!.docs[index]['year'],
                                    )
                                  : builtFriendsMessage(
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
                              cursorColor: mainColor,
                              cursorHeight: 30,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (messageController.text.isNotEmpty) {
                                        AppCubit.get(context).addMessage(
                                          email: userEmail,
                                          messageController: messageController,
                                          scrollController: scrollController,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: mainColor,
                                    )),
                                hintText: 'Message',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor!)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor!)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor!)),
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
                  backgroundColor: mainColor,
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
                        color: mainColor,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: mainColor,
                        cursorHeight: 30,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                AppCubit.get(context).addMessage(
                                  email: userEmail,
                                  messageController: messageController,
                                  scrollController: scrollController,
                                );
                              },
                              icon: Icon(
                                Icons.send,
                                color: mainColor,
                              )),
                          hintText: 'Message',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor!)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor!)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor!)),
                        ),
                        controller: messageController,
                        keyboardType: TextInputType.emailAddress,
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
