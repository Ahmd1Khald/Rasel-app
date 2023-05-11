import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import '../core/utils/constants/colors.dart';
import '../core/utils/constants/variables.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
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
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: AppColors.borderColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                      controller: codeController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty||value.length>6) {
                          return 'Invalid code number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)),
                        child: MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()&&AppVariables.verification==codeController.text) {
                                //navigateAndRemove(context: context,widget: const ChatScreen());
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: AppColors.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )),
                      ),
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
