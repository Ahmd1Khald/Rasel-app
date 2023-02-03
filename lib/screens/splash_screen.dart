import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chatapp/shared/const.dart';
import 'package:flutter/material.dart';

import 'loading_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 90,
              child: Image.asset(
                'assets/images/chat.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10,),
            // Text('سند للخدمات الماليه',style: TextStyle(fontSize: 16.sp,color: K.mainColor),)
          ],
        ),

        nextScreen: widget,
        splashIconSize: 250,
        duration: 4000,
        splashTransition: SplashTransition.sizeTransition,
        animationDuration: const Duration(seconds: 2),
      ),

    );
  }
}