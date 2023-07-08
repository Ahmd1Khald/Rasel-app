import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/colors.dart';
import '../../../../../../Core/utils/constants/styles.dart';

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
        cursorColor: AppColors.primaryGreen,
        decoration: InputDecoration(
          fillColor: AppColors.primaryGreen,
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
            borderSide: BorderSide(color: AppColors.primaryGreen!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryGreen!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryGreen!),
          ),
        ),
        controller: messageController,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
