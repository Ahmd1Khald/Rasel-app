import 'package:chatapp/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:chatapp/Features/auth/presentation/views/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/functions.dart';
import '../../../../../../core/widgets/components.dart';

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
          if (state is SuccessLoginState ||
              state is LoginSuccessGoogleSignInState) {
            myToast(state: "Login Success", toastState: ToastState.success);
            AppFunctions.submit(context);
          } else if (state is ErrorLoginState) {
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
                  padding: EdgeInsets.all(20.0.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Image.asset(
                        'assets/images/login.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      /* const SizedBox(
                      height: 20,
                    ),*/
                      /* TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.length < 11) {
                          return 'phone is too small';
                        }
                        return null;
                      },
                    ),*/
                      /*const SizedBox(
                      height: 20,
                    ),*/
                      /*TextFormField(
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColors.borderColor),
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColors.borderColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email is too small';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableTextFormField(
                      controller: passController,
                      hintText: "Password",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter a password";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        // Save password value
                      },
                    ),*/
                      // sharedTextField(
                      //     obsecure: isShowPass,
                      //     sufIconFun: () {
                      //       setState(() {
                      //         isShowPass = !isShowPass;
                      //       });
                      //     },
                      //     textEditingController: passController,
                      //     validation: (String value) {
                      //       if (value.isEmpty) {
                      //         return 'Password is too short';
                      //       }
                      //     },
                      //     lable: 'Password',
                      //     prefIcon: Icons.password),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)),
                        child: MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String num = '+20${phoneController.text}';
                                print(num);

                                ///TODO phone auth
                                /*AppCubit.get(context)
                                  .loginUser(emailController, passController);*/
                                // try {
                                //   AppCubit.get(context)
                                //       .loginUser(emailController, passController);
                                // } on FirebaseAuthException catch (e) {
                                //   if (e.code == 'user-not-found') {
                                //     showSnachBar(context, 'User not found');
                                //   } else if (e.code == 'wrong password') {
                                //     showSnachBar(context, 'Wrong Password');
                                //   }
                                // } catch (e) {
                                //   print(e);
                                //   showSnachBar(context, 'There is an Error');
                                // }
                              }
                            },
                            child: state is LoadingLoginState
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.backgroundColor,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              AppFunctions.push(
                                context: context,
                                screen: const RegisterScreen(),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )),
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
