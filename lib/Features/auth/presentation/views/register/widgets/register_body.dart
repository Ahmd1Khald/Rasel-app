import 'package:chatapp/Features/auth/presentation/views/login/widgets/login_components/email_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/phone_textfield.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/register_title.dart';
import 'package:chatapp/Features/auth/presentation/views/register/widgets/user_put_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../bloc/state.dart';
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
          if (state is AppSuccessRegisterState) {
            myToast(state: "Register Success", toastState: ToastState.success);
            AppFunctions.submit(context);
          } else if (state is AppErrorRegisterState) {
            myToast(state: "Register Failed", toastState: ToastState.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            /*appBar: AppBar(
            backgroundColor: AppColors.appColor,
            elevation: 0,
          ),*/
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
                        const PutUserImage(),
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
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
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
