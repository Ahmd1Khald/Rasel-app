import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/strings.dart';
import '../../../../../core/utils/constants/styles.dart';
import '../../../data/models/user_model.dart';
import '../../manger/chat_cubit/chat_cubit.dart';
import 'chat_widgets/chat_appbar.dart';
import 'chat_widgets/my_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var scrollController = ScrollController();
    UserModel? result;
    CollectionReference message =
        FirebaseFirestore.instance.collection(AppStrings.messagesCollection);
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: AppColors.chatBackGroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.lightDark,
              centerTitle: true,
              actions: const [ChatAppBar()],
            ),
            body: Column(
              children: [
                //Spacer(),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) => BuiltMyMessage(
                    backgroundColor: AppColors.green,
                    image: snapshot.data?.docs[index]['image'],
                    msg: snapshot.data?.docs[index]['messages'][index],
                    name: snapshot.data?.docs[index]['name'],
                    time: snapshot.data?.docs[index]['time'],
                    year: snapshot.data?.docs[index]['year'],
                    phone: '',
                  ),
                  reverse: true,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: snapshot.data!.docs.isNotEmpty
                      ? snapshot.data!.docs.length
                      : 0,
                )),
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
                            scrollController: scrollController,
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
        });
  }
}
