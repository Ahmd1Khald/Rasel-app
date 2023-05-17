/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'core/utils/constants/colors.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>
      (
      stream: message.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: HexColor('#dedede'),
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
        color: AppColors.backgroundColor,)),
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
    );
  }
}
*/
