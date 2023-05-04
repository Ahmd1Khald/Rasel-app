import 'package:chatapp/Features/start/presentation/views/loading_screen.dart';
import 'package:go_router/go_router.dart';
import '../../Features/start/presentation/views/splash_screen.dart';

abstract class AppRouter {

  static const kHomeView = '/loadingView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const LoadingScreen(),
      ),
    ],
  );
}
