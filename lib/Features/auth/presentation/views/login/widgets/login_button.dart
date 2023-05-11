import 'package:chatapp/core/utils/constants/colors.dart';
import 'package:chatapp/core/utils/constants/functions.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/variables.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key, formKey,}) : super(key: key);

  final formKey = GlobalKey<FormState>();


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
          onPressed: ()async {

          },
          child: Text(
            'Log in',
            style: AppStyles.title2,
          )),
    );
  }
}
