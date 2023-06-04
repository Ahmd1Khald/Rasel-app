import 'package:RASEL/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/constants/styles.dart';

class VerifyCodeForm extends StatelessWidget {
  const VerifyCodeForm({
    super.key,
    required this.codeController1,
    required this.codeController2,
    required this.codeController3,
    required this.codeController4,
    required this.codeController5,
    required this.codeController6,
  });

  final TextEditingController codeController1;
  final TextEditingController codeController2;
  final TextEditingController codeController3;
  final TextEditingController codeController4;
  final TextEditingController codeController5;
  final TextEditingController codeController6;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            autofocus: true,
            cursorColor: AppColors.lightGrey,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController1,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.w),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.w),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            cursorColor: AppColors.lightGrey,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController2,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.w),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.w),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            cursorColor: AppColors.lightGrey,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController3,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.h),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.h),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            cursorColor: AppColors.green,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController4,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.h),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.h),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            cursorColor: AppColors.green,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController5,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.h),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.h),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            cursorColor: AppColors.green,
            style: AppStyles.title2.copyWith(color: AppColors.green),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: codeController6,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey, width: 2.h),
              ),
              enabled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.h),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ],
    );
  }
}
