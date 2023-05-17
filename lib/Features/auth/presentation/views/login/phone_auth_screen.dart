import 'package:chatapp/Features/auth/presentation/manger/phone_cubit/phone_cubit.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/phone_components/otp_button.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/phone_components/otp_code_screen.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/constants/assets_images.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/functions.dart';
import '../../../../../core/utils/constants/styles.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => PhoneCubit(),
      child: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          //Success
          if (state is PhoneSuccessSendOtpState) {
            myToast(state: 'Send Success', toastState: ToastState.success);
            AppFunctions.push(
              context: context,
              screen: OtpScreen(
                userPhoneNumber: phoneController.text,
                cubit: PhoneCubit.get(context),
              ),
            );
          } else if (state is PhoneSuccessConfirmOtpState) {
            myToast(state: 'Confirmed!', toastState: ToastState.success);
            AppFunctions.submit(context: context, userUid: state.uid);
            AppVariables.userPhoneAuth = true;
          }
          //Error
          else if (state is PhoneErrorSendOtpState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          } else if (state is PhoneErrorConfirmOtpState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          }
          //Loading
          else if (state is PhoneLoadingSendOtpState) {
            //AppFunctions.loadingPage(context: context);
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => Center(
                child: circleLoading(color: AppColors.lightGrey),
              ),
            );
          } else if (state is PhoneLoadingConfirmOtpState) {
            AppFunctions.loadingPage(context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.3,
                        image: AssetImage(AppAssetsImages.phoneImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.sp),
                                      color:
                                          AppColors.midGrey!.withOpacity(0.2),
                                      border: Border.all(
                                          color: AppColors.lightGrey),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${AppFunctions.generateCountryFlag()} +20',
                                        style: AppStyles.title3,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    autofocus: true,
                                    cursorColor: AppColors.lightGrey,
                                    style: AppStyles.title3.copyWith(
                                      color: AppColors.lightGrey,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.sp),
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey),
                                      ),
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.phone,
                                        color: AppColors.midGreen,
                                      ),
                                      hintText: 'Phone number',
                                      hintStyle: AppStyles.title3
                                          .copyWith(letterSpacing: 2.0),
                                      // enabled: true,
                                    ),
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your phone number';
                                      } else if (value.length < 10) {
                                        return 'Too short phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: OtpButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    PhoneCubit.get(context).sendOtp(
                                        phoneNumber: phoneController.text);
                                  }
                                },
                                title: 'Send',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
