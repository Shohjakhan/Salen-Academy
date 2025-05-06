import 'package:go_router/go_router.dart';
import 'package:salen_academy/src/presentation/pages/home_page/home_page.dart';
import 'package:salen_academy/src/presentation/pages/profile_page/profile_page.dart';
import 'package:salen_academy/src/presentation/pages/sign_up/sing_up_page.dart';
import 'package:salen_academy/src/presentation/pages/video_page/video_page.dart';

import '../presentation/pages/sign_in/sign_in_page.dart';
import '../presentation/pages/splash_page/splash_page.dart';
import '../presentation/pages/welcome_page/welcome_page.dart';

abstract class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: SplashPage.routeName,
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: WelcomePage.routeName,
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: SignUpPage.routeName,
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: SignInPage.routeName,
        path: '/signin',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
          name: HomePage.routeName,
          path: '/home',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              name: ProfilePage.routeName,
              path: 'profile',
              builder: (context, state) => ProfilePage(),
            ),
          ]),
      GoRoute(
        name: VideoPage.routeName,
        path: '/video',
        builder: (context, state) => const VideoPage(),
      ),
    ],
  );
}
