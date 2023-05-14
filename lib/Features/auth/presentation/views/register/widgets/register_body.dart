import 'package:chatapp/Features/auth/presentation/views/login/widgets/login_components/email_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/phone_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/register_title.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/user_put_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/functions.dart';
import '../../../../../../core/widgets/components.dart';
import '../../../manger/register_cubit/register_cubit.dart';
import '../../login/widgets/login_components/last_text_auth.dart';
import '../../login/widgets/login_components/password_textfield.dart';
import 'login_button.dart';
import 'name_textfield.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          //Success
          if (state is RegisterSuccessUploadPhotoState) {
            myToast(state: "Success!", toastState: ToastState.success);
            Navigator.pop(context);
          } else if (state is RegisterSuccessState) {
            myToast(state: "Register success!", toastState: ToastState.success);
            AppFunctions.submit(context: context, userUid: state.uid);
          }
          //Error
          else if (state is RegisterErrorUploadPhotoState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          } else if (state is RegisterErrorSetPhotoState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          } else if (state is RegisterErrorState) {
            myToast(state: state.errorMsg, toastState: ToastState.error);
            Navigator.pop(context);
          }
          //Loading
          else if (state is RegisterLoadingUploadPhotoState) {
            AppFunctions.loadingPage(context: context);
          } else if (state is RegisterLoadingState) {
            AppFunctions.loadingPage(context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 40.0.h, right: 30.w, left: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PutUserImage(
                          image: RegisterCubit.get(context).userImage,
                          onPressed: () {
                            RegisterCubit.get(context).setImage();
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const RegisterTitle(title: 'Register to get started!'),
                        SizedBox(
                          height: 5.h,
                        ),
                        NameTextField(
                          nameController: nameController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        PhoneTextField(
                          phoneController: phoneController,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        EmailTextField(emailController: emailController),
                        SizedBox(
                          height: 20.h,
                        ),
                        PassTextField(
                          passController: passController,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: RegisterButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('name => ${nameController.text}');
                                print('phone => ${phoneController.text}');
                                print('email => ${emailController.text}');
                                print('pass => ${passController.text}');

                                RegisterCubit.get(context).userRegister(
                                  emailController: emailController,
                                  passController: passController,
                                  nameController: nameController,
                                  phoneController: phoneController,
                                  image: RegisterCubit.get(context).userImage ??
                                      'null',
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        const LastText(
                          firstText: 'Do have an account?',
                          secondText: 'Log in',
                        ),
                      ],
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
