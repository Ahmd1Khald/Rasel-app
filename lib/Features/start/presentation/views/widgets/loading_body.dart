import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../core/helpers/cachehelper.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../screens/chat_screen.dart';
import '../../../../auth/presentation/views/login/login_screen.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        backgroundColor: AppColors.appColor,
        splash: SpinKitWave(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color:
                    index.isEven ? Colors.white : Colors.white.withOpacity(0.5),
              ),
            );
          },
          duration: const Duration(milliseconds: 1500),
        ),
        nextScreen: CacheHelper.getDate(key: 'LoginDone') == true
            ? const ChatScreen()
            : const LoginScreen(),
        splashIconSize: 250.sp,
        duration: 1000,
        //splashTransition: SplashTransition.slideTransition,
        animationDuration: const Duration(seconds: 3),
      ),
    );
  }
}
