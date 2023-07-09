import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/styles.dart';

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Text(
          'Ahmed Khaled',
          maxLines: 1,
          style: AppStyles.postUserName
              .copyWith(fontSize: 22.sp, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
