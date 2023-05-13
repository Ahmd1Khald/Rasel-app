import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/constants/colors.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({
    super.key,
    emailController,
  });

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.hintText,
      cursorColor: AppColors.lightGrey,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: AppStyles.hintText,
        focusColor: AppColors.lightGrey,
        fillColor: AppColors.lightGrey,
        prefixIcon: const Icon(
          FontAwesomeIcons.envelope,
          color: AppColors.inActiveBorderColor,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.inActiveBorderColor,
        )),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inActiveBorderColor,
          ),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: AppColors.green)),
      ),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is too small';
        }
        return null;
      },
    );
  }
}
