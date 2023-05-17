import 'package:chatapp/Features/auth/presentation/views/login/login_screen.dart';
import 'package:chatapp/Features/chat/presentation/views/chat_screen.dart';
import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/cachehelper.dart';
import '../../widgets/components.dart';
import 'colors.dart';

class AppFunctions {
  static String dateTimeFormatted(String s) {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    if (s == 't') {
      return formattedTime;
    }
    if (s == 'y') {
      return formattedDate;
    } else {
      return 'Enter t or y only';
    }
  }

  static void submit({required context, required String userUid}) {
    CacheHelper.saveData(key: AppKeys.loginDone, value: true);
    CacheHelper.saveData(key: AppKeys.userUid, value: userUid);
    AppFunctions.pushReplacement(
        context: context,
        screen: ChatScreen(
          uid: userUid,
        ));
  }

  static void leave({required context}) {
    AppFunctions.pushReplacement(
      context: context,
      screen: const LoginScreen(),
    );
  }

  static void pushReplacement({
    required context,
    required Widget screen,
  }) {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => screen,
        ));
  }

  static void push({
    required context,
    required Widget screen,
  }) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => screen,
        ));
  }

  static String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  static loadingPage({required context}) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: circleLoading(color: AppColors.lightGrey),
        ),
      );

  static scrollToObject(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
    );
  }
}
