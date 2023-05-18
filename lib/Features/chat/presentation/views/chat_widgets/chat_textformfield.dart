import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/styles.dart';

class ChatTextFormField extends StatefulWidget {
  final TextEditingController messageController;
  const ChatTextFormField(
      {Key? key, required this.onPressed, required this.messageController})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  State<ChatTextFormField> createState() => _ChatTextFormFieldState();
}

class _ChatTextFormFieldState extends State<ChatTextFormField> {
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Padding(
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
            onPressed: widget.onPressed,
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
    );
  }
}
