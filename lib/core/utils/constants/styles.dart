import 'package:chatapp/core/utils/constants/colors.dart';
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

  static TextStyle hintText = GoogleFonts.ubuntu(
    color: AppColors.midGrey,
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
  );
}
