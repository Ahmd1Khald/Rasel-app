import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/constants/styles.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0.h, top: 5.0.h),
      child: Text(
        title,
        style: AppStyles.title3,
      ),
    );
  }
}
