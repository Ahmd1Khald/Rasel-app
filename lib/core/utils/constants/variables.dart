import '../../helpers/cachehelper.dart';

class AppVariables{

  static Uri appUrl = Uri.parse('https://github.com/Ahmd1Khald');

  static String userEmail = CacheHelper.getDate(key: 'userEmail');

  static var verification = '';
}