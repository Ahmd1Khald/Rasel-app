import 'package:RASEL/core/utils/constants/colors.dart';
import 'package:RASEL/core/utils/constants/fonts_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle title1 = GoogleFonts.ubuntu(
      color: AppColors.lightGrey, fontWeight: FontWeight.bold, fontSize: 35.sp);

  static TextStyle title2 = GoogleFonts.ubuntu(
      color: AppColors.lightGrey, fontWeight: FontWeight.bold, fontSize: 22.sp);

  static TextStyle drawerStyles = GoogleFonts.tajawal(
    color: AppColors.deepDark,
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
  );

  static TextStyle title3 = GoogleFonts.ubuntu(
    color: AppColors.midGrey,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static TextStyle drawerHeaderStyle = GoogleFonts.nunito(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static TextStyle message = GoogleFonts.manrope(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: AppFontsSize.messageFontSize,
  );

  static TextStyle postUserName = GoogleFonts.manrope(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 17,
  );

  static TextStyle postDate = GoogleFonts.manrope(
    color: Colors.grey[900],
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );

  static TextStyle postText = GoogleFonts.manrope(
    color: Colors.black,
    height: 1.4,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static TextStyle postTages = GoogleFonts.manrope(
    color: Colors.blue,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static TextStyle hintText = GoogleFonts.ubuntu(
    color: AppColors.midGrey,
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
  );
}
