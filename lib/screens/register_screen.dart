import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cachehelper.dart';
import '../rusableTextFormField.dart';
import '../shared/components.dart';
import '../shared/const.dart';
import 'chat_screen.dart';

class RegiterScreen extends StatefulWidget {
  const RegiterScreen({Key? key}) : super(key: key);

  @override
  State<RegiterScreen> createState() => _RegiterScreenState();
}

class _RegiterScreenState extends State<RegiterScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessRegisterState) {
          myToast(state: "Register Success", toastState: toastState.Success);
          submit(context);
        } else if (state is AppErrorRegisterState) {
          myToast(state: "Register Failed", toastState: toastState.Error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            backgroundColor: mainColor,
            elevation: 0,
          ),
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
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name is too small';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                    ),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).registerUser(
                                emailController: emailController,
                                nameController: nameController,
                                phoneController: phoneController,
                                passController: passController,
                              );
                              // try {
                              //   AppCubit.get(context).registerUser(
                              //       emailController, passController);
                              //   showSnachBar(
                              //       context, 'Email created successfully');
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'weak-password') {
                              //     showSnachBar(context, 'Password too weak');
                              //   } else if (e.code == 'email-already-in-use') {
                              //     showSnachBar(
                              //         context, 'Email was already registed');
                              //   } else {
                              //     showSnachBar(context, 'Change email format');
                              //   }
                              // } catch (e) {
                              //   showSnachBar(context, 'There is an Error');
                              // }
                            }
                          },
                          child: state is AppLoadingRegisterState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )),
                    ),
                    const SizedBox(
                      height: 30,
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
