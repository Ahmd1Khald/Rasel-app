import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/styles.dart';

class UserBio extends StatelessWidget {
  const UserBio({Key? key, required this.bio}) : super(key: key);

  final String? bio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Text(
          bio ?? '',
          maxLines: 2,
          style: AppStyles.hintPost
              .copyWith(fontSize: 15.sp, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
