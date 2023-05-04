import 'package:chatapp/core/utils/app_route.dart';
import 'package:intl/intl.dart';

import '../../../screens/chat_screen.dart';
import '../../helpers/cachehelper.dart';
import '../../widgets/components.dart';

class AppFunctions{

  static String dateTimeFormatted (String s) {
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
    CacheHelper.saveData(key: 'LoginDone', value: true);
    AppRouter.router.pushReplacement(AppRouter.kLoadingView);
  }
}