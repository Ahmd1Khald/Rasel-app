import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Core/utils/constants/colors.dart';
import '../../../../../../Core/utils/constants/fonts_sizes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
        backgroundColor: AppColors.lightDark,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Message Font Size:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 250.w,
                  child: Slider(
                    value: AppFontsSize.messageFontSize,
                    activeColor: AppColors.backgroundColor,
                    inactiveColor: Colors.grey,
                    min: 10.sp,
                    max: 40.sp,
                    onChanged: (value) {
                      setState(() {
                        AppFontsSize.messageFontSize = value;
                      });
                    },
                  ),
                ),
                Text(
                  "Rasel Now",
                  style: GoogleFonts.aBeeZee(
                    fontSize: AppFontsSize.messageFontSize,
                  ),
                ),
                SizedBox(
                  height: 20.h,
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
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundColor),
                        onPressed: () {
                          // AppCubit.get(context).saveSettings();
                          // Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
