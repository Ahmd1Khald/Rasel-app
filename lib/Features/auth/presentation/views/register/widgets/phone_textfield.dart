import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/styles.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController phoneController;
  PhoneTextField({
    Key? key,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.hintText,
      cursorColor: AppColors.cursorColor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          FontAwesomeIcons.phone,
          color: AppColors.lightGrey,
        ),
        hintText: 'Enter your phone number',
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
      controller: phoneController,
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.length < 11) {
          return 'Invalid phone number';
        }
        return null;
      },
    );
  }
}
