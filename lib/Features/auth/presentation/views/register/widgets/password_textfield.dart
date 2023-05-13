import 'package:chatapp/core/utils/constants/colors.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PassTextField extends StatefulWidget {
  final TextEditingController passController;

  const PassTextField({
    super.key,
    required this.passController,

  });

  @override
  _PassTextFieldState createState() => _PassTextFieldState();
}

class _PassTextFieldState extends State<PassTextField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.hintText,
      cursorColor: AppColors.lightGrey,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          FontAwesomeIcons.lock,
          color: Colors.white,
        ),
        hintText: 'Enter your password',
        hintStyle: AppStyles.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            color: Colors.white,
          ),
          onPressed: _toggle,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrey)),
        enabledBorder: OutlineInputBorder(
            borderSide:BorderSide(color: AppColors.lightGrey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green)),
      ),
      controller: widget.passController,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'password is too small';
        }
        return null;
      },
    );
  }
}
