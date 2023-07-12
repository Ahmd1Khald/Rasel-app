import 'package:RASEL/core/utils/constants/colors.dart';
import 'package:RASEL/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserBioTextField extends StatefulWidget {
  final TextEditingController bioController;

  const UserBioTextField({
    super.key,
    required this.bioController,
  });

  @override
  _UserBioTextFieldState createState() => _UserBioTextFieldState();
}

class _UserBioTextFieldState extends State<UserBioTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 90.h,
        child: TextFormField(
          maxLines: null,
          expands: true,
          style: AppStyles.hintText,
          cursorColor: AppColors.lightGrey,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              FontAwesomeIcons.anglesRight,
              color: Colors.white,
            ),
            hintText: 'Enter your bio',
            hintStyle: AppStyles.hintText,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.green)),
          ),
          controller: widget.bioController,
          keyboardType: TextInputType.multiline,
          validator: (value) {
            if (value!.isEmpty) {
              return 'bio is too small';
            }
            return null;
          },
        ),
      ),
    );
  }
}
