import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/constants/colors.dart';

class PhoneSignInButton extends StatelessWidget {
  const PhoneSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 130.w,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.8),
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(20.sp),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.green,
            AppColors.green2,
            AppColors.midGreen,
          ],
        ),
      ),
      child: Icon(
        FontAwesomeIcons.phone,
        color: AppColors.lightGrey,
        size: 30.sp,
      ),
    );
  }
}
