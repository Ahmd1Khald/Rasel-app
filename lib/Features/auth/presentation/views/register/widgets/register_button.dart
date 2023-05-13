import 'package:chatapp/core/utils/constants/colors.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    Key? key,
    formKey,
    required this.onPressed,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Register',
            style: AppStyles.title2,
          )),
    );
  }
}
