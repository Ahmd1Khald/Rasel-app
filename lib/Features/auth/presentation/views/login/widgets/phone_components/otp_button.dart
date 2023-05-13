import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/styles.dart';

class OtpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const OtpButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
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
            style: AppStyles.title2,
          )),
    );
  }
}
