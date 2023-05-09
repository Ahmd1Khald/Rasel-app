import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/styles.dart';

class OrLine extends StatelessWidget {
  const OrLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.h,
          width: 120.w,
          color: AppColors.midGrey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Text('OR',style: AppStyles.title3,),
        ),
        Container(
          height: 1.h,
          width: 120.w,
          color: AppColors.midGrey,
        ),
      ],
    );
  }
}
