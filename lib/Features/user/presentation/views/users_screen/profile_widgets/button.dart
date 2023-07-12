import 'package:RASEL/core/utils/constants/colors.dart';
import 'package:RASEL/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserButton extends StatelessWidget {
  UserButton({
    Key? key,
    formKey,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        color: AppColors.grey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.green,
            AppColors.green2,
            AppColors.midGreen,
            //AppColors.lightGrey,
          ],
        ),
      ),
      child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: AppStyles.title3,
          )),
    );
  }
}
