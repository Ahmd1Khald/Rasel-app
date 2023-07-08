import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/functions.dart';
import '../../../../../../../core/utils/constants/styles.dart';
import '../../../register/register_screen.dart';

class LastText extends StatelessWidget {
  const LastText({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$firstText ',
          style: AppStyles.title3.copyWith(
            color: AppColors.lightGrey,
            fontSize: 15.sp,
          ),
        ),
        TextButton(
          onPressed: () {
            if (secondText == 'Sign up') {
              AppFunctions.push(
                context: context,
                screen: RegisterScreen(),
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(
            secondText,
            style: AppStyles.title3.copyWith(
              color: Colors.white,
              fontSize: 17.sp,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
