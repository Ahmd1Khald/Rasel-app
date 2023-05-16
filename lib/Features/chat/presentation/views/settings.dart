import 'package:chatapp/Features/chat/presentation/manger/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/fonts_sizes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        /*if (state is AppSuccessGetFontSizeState) {
          myToast(state: "Saved Successfully", toastState: ToastState.success);
          //AppFunctions.submit(context);
        }
        else if (state is AppErrorGetFontSizeState) {
          myToast(state: "Save Failed", toastState: ToastState.error);
        }*/
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Settings",
            ),
            backgroundColor: AppColors.backgroundColor,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Message Font Size:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Slider(
                        value: AppFontsSize.messageFontSize,
                        activeColor: AppColors.backgroundColor,
                        inactiveColor: Colors.grey,
                        min: 10,
                        max: 40,
                        onChanged: (value) {
                          setState(() {
                            AppFontsSize.messageFontSize = value;
                          });
                        },
                      ),
                      Text(
                        "Hello world",
                        style: GoogleFonts.aBeeZee(
                          fontSize: AppFontsSize.messageFontSize,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.backgroundColor),
                              onPressed: () {
                                setState(() {
                                  AppFontsSize.messageFontSize = 15;
                                });
                                //AppCubit.get(context).saveSettings();
                              },
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.backgroundColor),
                              onPressed: () {
                                // AppCubit.get(context).saveSettings();
                                // Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
