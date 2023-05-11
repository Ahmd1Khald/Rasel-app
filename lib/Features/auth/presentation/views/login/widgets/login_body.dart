import 'package:chatapp/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/login_title.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/password_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/login/widgets/phone_signin_button.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/functions.dart';
import '../../../../../../core/utils/constants/variables.dart';
import '../../../../../../core/widgets/components.dart';
import '../../../../../../screens/chat_screen.dart';
import 'email_textfield.dart';
import 'google_signin_button.dart';
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
            CacheHelper.saveData(key: AppKeys.userUid, value: state.uid);
          } else if (state is LoginSuccessGoogleSignInState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(context);
            CacheHelper.saveData(key: AppKeys.userUid, value: state.uid);
          } else if (state is ErrorLoginState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
          } else if (state is LoginErrorGoogleSignInState) {
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
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              color: AppColors.grey.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.green,
                                  AppColors.green2,
                                  AppColors.midGreen,
                                  //AppColors.lightGrey,
                                ],
                              ),
                            ),
                            child: MaterialButton(
                                onPressed: ()async {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).loginUser(
                                      emailController,
                                      passController,
                                    );
                                    print('email => ${emailController.text}');
                                    print('pass => ${passController.text}');
                                  }
                                },
                                child: Text(
                                  'Log in',
                                  style: AppStyles.title2,
                                )),
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
                              ///Todo navigate to otp screen
                            },
                            child: const PhoneSignInButton(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      if (state is LoginLoadingGoogleSignInState ||
                          state is LoadingLoginState)
                        circleLoading(color: AppColors.lightGrey),
                      SizedBox(
                        height: 15.h,
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
