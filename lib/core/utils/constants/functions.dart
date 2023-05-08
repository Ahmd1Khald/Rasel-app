import 'package:chatapp/core/utils/constants/keys.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../helpers/cachehelper.dart';

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

  static void submit(context) {
    CacheHelper.saveData(key: AppKeys.loginDone, value: true);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(
        builder: (context) => const ChatScreen(),
    ));
  }

  static void pushReplacement({
    required context,
    required Widget screen,
  }) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(
      builder: (context) => screen,
    ));
  }

  static void push({
    required context,
    required Widget screen,
  }) {
    Navigator.push(
        context, CupertinoPageRoute(
      builder: (context) => screen,
    ));
  }
}
