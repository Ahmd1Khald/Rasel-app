import 'package:RASEL/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:RASEL/Features/auth/presentation/views/login/widgets/login_components/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/functions.dart';
import '../../../../../../../core/widgets/components.dart';
import '../../phone_auth_screen.dart';
import '../google_components/google_signin_button.dart';
import '../phone_components/phone_signin_button.dart';
import 'email_textfield.dart';
import 'last_text_auth.dart';
import 'login photo.dart';
import 'login_button.dart';
import 'login_title.dart';
import 'or_line.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          //Success
          if (state is LoginSuccessState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(
              context: context,
              userUid: state.uid,
            );
          } else if (state is LoginSuccessGoogleSignInState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(
              context: context,
              userUid: state.uid,
            );
          }
          //Error
          else if (state is LoginErrorState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          } else if (state is LoginErrorGoogleSignInState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          }
          //Loading
          else if (state is LoginLoadingState) {
            AppFunctions.loadingPage(context: context);
          } else if (state is LoginLoadingGoogleSignInState) {
            AppFunctions.loadingPage(context: context);
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
                      const LoginTitle(title: 'Log in to get started!'),
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                emailController,
                                passController,
                              );
                              print('email => ${emailController.text}');
                              print('pass => ${passController.text}');
                            }
                          },
                        ),
                      ),
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
                            onTap: () async {
                              await LoginCubit.get(context).googleSignIn();
                            },
                            child: const GoogleSignInButton(),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          InkWell(
                            onTap: () {
                              AppFunctions.push(
                                context: context,
                                screen: const PhoneAuthScreen(),
                              );
                            },
                            child: const PhoneSignInButton(),
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
