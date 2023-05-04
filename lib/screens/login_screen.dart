import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:chatapp/screens/otp.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/constants/colors.dart';
import '../core/utils/constants/functions.dart';
import '../core/widgets/components.dart';
import '../core/utils/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessLoginState) {
          myToast(state: "Login Success", toastState: ToastState.success);
          AppFunctions.submit(context);
        } else if (state is AppErrorLoginState) {
          myToast(state: "Login Failed", toastState: ToastState.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.appColor,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/images/login.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: const TextStyle(color: AppColors.borderColor),
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '+20',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.length < 11) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
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
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: num,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  await FirebaseAuth.instance
                                      .signInWithCredential(credential);
                                },
                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    const SnackBar(
                                        content: Text('Invalid phone number'));
                                  }
                                },
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  AppVariables.verification = verificationId;
                                  navigateTo(context, const OtpScreen());
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {
                                      AppVariables.verification = verificationId;
                                },
                              );
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
                          child: state is AppLoadingLoginState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.appColor,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: AppColors.appColor,
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
                            navigateTo(context, const RegisterScreen());
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
    );
  }
}
