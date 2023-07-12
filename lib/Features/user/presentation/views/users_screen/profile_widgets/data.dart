import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/styles.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key, required this.type, required this.data})
      : super(key: key);

  final String type;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          type,
          style: AppStyles.postUserName.copyWith(fontSize: 15.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          data,
          style: AppStyles.postDate,
        ),
      ],
    );
  }
}
