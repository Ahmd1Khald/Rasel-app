import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/local/cachehelper.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../rusableTextFormField.dart';
import '../shared/components.dart';
import '../shared/const.dart';

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
          myToast(state: "Login Success", toastState: toastState.Success);
          submit(context);
        }
         else if (state is AppErrorLoginState) {
          myToast(state: "Login Failed", toastState: toastState.Error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/login.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                   /* TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
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
                    ),
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {

                              AppCubit.get(context)
                                  .loginUser(emailController, passController);
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
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(30)),
                      child: MaterialButton(
                          onPressed: () {
                            navigateTo(context, const RegiterScreen());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.blue,
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
