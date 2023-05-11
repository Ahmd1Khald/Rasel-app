import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/cachehelper.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/functions.dart';
import '../../../../../core/widgets/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0,right: 20,left: 20),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          AppCubit.get(context).image == null
                              ? const CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                            AssetImage('assets/images/user.png'),
                          )
                              : CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.grey,
                            backgroundImage: FileImage(
                              AppCubit.get(context).image!,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 18,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).setImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(color: AppColors.borderColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
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
                        hintStyle: TextStyle(color: AppColors.borderColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
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
                        hintStyle: TextStyle(color: AppColors.borderColor),
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
                    ///todo passtextfield
                    const SizedBox(
                      height: 50,
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
                              AppCubit.get(context).registerUser(
                                emailController: emailController,
                                nameController: nameController,
                                phoneController: phoneController,
                                passController: passController,
                                image: CacheHelper.getDate(key: 'photoURL')
                              );
                              AppFunctions.pushReplacement(context: context,screen: const ChatScreen());
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
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.backgroundColor,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                      color: AppColors.backgroundColor,
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
