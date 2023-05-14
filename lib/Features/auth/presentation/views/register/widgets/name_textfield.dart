import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/styles.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required this.nameController,
  }) : super(key: key);
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.hintText,
      cursorColor: AppColors.cursorColor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FontAwesomeIcons.user,
          color: AppColors.lightGrey,
        ),
        hintText: 'Enter your name',
        hintStyle: AppStyles.hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inActiveBorderColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inActiveBorderColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.activeBorderColor),
        ),
      ),
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is too small';
        }
        return null;
      },
    );
  }
}
