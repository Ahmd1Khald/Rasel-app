import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/constants/assets_images.dart';
import '../../../../core/utils/constants/colors.dart';
import 'loading_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: AppColors.appColor,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
              width: 120.w,
              child: Image.asset(
                AssetsImages.logoImage,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        nextScreen: const LoadingScreen(),
        splashIconSize: 250,
        duration: 3000,
        splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
