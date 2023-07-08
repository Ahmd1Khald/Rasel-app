import 'package:RASEL/core/utils/constants/colors.dart';
import 'package:RASEL/core/utils/constants/fonts_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle title1 = GoogleFonts.ubuntu(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 35.sp,
  );

  static TextStyle title2 = GoogleFonts.ubuntu(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 22.sp,
  );

  static TextStyle drawerStyles = GoogleFonts.tajawal(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );

  static TextStyle title3 = GoogleFonts.ubuntu(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 19.sp,
  );

  static TextStyle drawerHeaderStyle = GoogleFonts.nunito(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 25.sp,
  );

  static TextStyle message = GoogleFonts.manrope(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: AppFontsSize.messageFontSize,
  );

  static TextStyle postUserName = GoogleFonts.manrope(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 17.sp,
  );

  static TextStyle postDate = GoogleFonts.manrope(
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
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
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );

  static TextStyle hintPost = GoogleFonts.ubuntu(
    color: Colors.grey[500],
    fontWeight: FontWeight.bold,
    fontSize: 11.sp,
  );
}
