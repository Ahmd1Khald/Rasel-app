import 'package:RASEL/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/constants/colors.dart';

class UserNameTextField extends StatefulWidget {
  final TextEditingController nameController;
  const UserNameTextField({
    super.key,
    required this.nameController,
  });

  @override
  State<UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<UserNameTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: AppStyles.hintText,
        cursorColor: AppColors.lightGrey,
        decoration: InputDecoration(
          hintText: 'Enter your name',
          hintStyle: AppStyles.hintText,
          focusColor: AppColors.lightGrey,
          fillColor: AppColors.lightGrey,
          prefixIcon: const Icon(
            FontAwesomeIcons.keyboard,
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
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.green)),
        ),
        controller: widget.nameController,
        keyboardType: TextInputType.name,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Email is too small';
          }
          return null;
        },
      ),
    );
  }
}
