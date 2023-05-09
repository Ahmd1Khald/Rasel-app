import 'package:chatapp/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/password_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/register/register_screen.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/functions.dart';
import '../../../../../../core/widgets/components.dart';
import '../../../../../../core/widgets/rusableTextFormField.dart';
import 'email_textfield.dart';
import 'last_text_auth.dart';
import 'login photo.dart';
import 'login_button.dart';
import 'or_line.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(context);
            CacheHelper.saveData(key: 'userUid', value: state.uid);
          }
          else if (state is LoginSuccessGoogleSignInState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(context);
            CacheHelper.saveData(key: 'userUid', value: state.uid);
          }
          else if (state is ErrorLoginState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(30.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoginPhoto(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0.h, top: 5.0.h),
                        child: Text(
                          'Log in to get started!',
                          style: AppStyles.title3,
                        ),
                      ),
                      EmailTextField(
                        emailController: emailController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      PassTextField(passController: passController),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                          child: LoginButton(
                        formKey: formKey,
                      )),
                      SizedBox(
                        height: 20.h,
                      ),
                      const OrLine(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 65.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.8),
                                border: Border.all(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.green,
                                    AppColors.green2,
                                    AppColors.midGreen,
                                  ],
                                ),
                              ),
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: AppColors.lightGrey,
                                size: 30.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 65.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.8),
                                border: Border.all(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.green,
                                    AppColors.green2,
                                    AppColors.midGreen,
                                  ],
                                ),
                              ),
                              child: Icon(
                                FontAwesomeIcons.mobile,
                                color: AppColors.lightGrey,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      const LastText(
                        firstText: 'Don\'t have an account?',
                        secondText: 'Sign up',
                      ),
                    ],
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
