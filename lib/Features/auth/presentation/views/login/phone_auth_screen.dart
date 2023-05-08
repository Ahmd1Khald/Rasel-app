import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/functions.dart';
import '../../../../../core/widgets/components.dart';
import '../../manger/login_cubit/login_cubit.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
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
                      TextFormField(
                        cursorColor: AppColors.cursorColor,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle:
                              const TextStyle(color: AppColors.borderColor),
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
                              borderSide:
                                  BorderSide(color: AppColors.borderColor)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.borderColor)),
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                            onPressed: () {

                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
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
