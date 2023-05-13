import 'package:chatapp/Features/auth/presentation/views/login/widgets/phone_components/verify_code_form.dart';
import 'package:chatapp/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../manger/phone_cubit/phone_cubit.dart';
import 'confirm-otp_title.dart';
import 'confirm_otp_image.dart';
import 'counter_down.dart';
import 'otp_button.dart';

class OtpScreen extends StatelessWidget {
  final String userPhoneNumber;

  OtpScreen({
    Key? key,
    required this.userPhoneNumber,
    required this.cubit,
  }) : super(key: key);
  final codeController1 = TextEditingController();
  final codeController2 = TextEditingController();
  final codeController3 = TextEditingController();
  final codeController4 = TextEditingController();
  final codeController5 = TextEditingController();
  final codeController6 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final PhoneCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const ConfirmOtpImage(),
                SizedBox(height: 15.h),
                const ConfirmOtpTitle(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.h, horizontal: 18.0.w),
                  child: VerifyCodeForm(
                    codeController1: codeController1,
                    codeController2: codeController2,
                    codeController3: codeController3,
                    codeController4: codeController4,
                    codeController5: codeController5,
                    codeController6: codeController6,
                  ),
                ),
                const CountdownWidget(),
                SizedBox(
                  height: 50.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: OtpButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String otpCode =
                            '${codeController1.text}${codeController2.text}${codeController3.text}${codeController4.text}${codeController5.text}${codeController6.text}';
                        print('otp code => $otpCode');
                        cubit.confirmOtp(otpCode: otpCode);
                      }
                    },
                    title: 'Confirm',
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
