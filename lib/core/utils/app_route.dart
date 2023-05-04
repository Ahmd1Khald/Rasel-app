import 'package:chatapp/Features/auth/presentation/views/login/login_screen.dart';
import 'package:chatapp/Features/auth/presentation/views/login/phone_auth_screen.dart';
import 'package:chatapp/Features/start/presentation/views/loading_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:go_router/go_router.dart';
import '../../Features/auth/presentation/views/register/register_screen.dart';
import '../../Features/start/presentation/views/splash_screen.dart';
import '../../screens/otp.dart';

abstract class AppRouter {
  static const kLoadingView = '/loadingView';
  static const kChatView = '/chatView';
  static const kRegisterView = '/chatView';
  static const kLoginView = '/chatView';
  static const kOtpView = '/otpView';
  static const kPhoneView = '/phoneView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kLoadingView,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: kChatView,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: kOtpView,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: kPhoneView,
        builder: (context, state) => const PhoneAuthScreen(),
      ),

    ],
  );
}
